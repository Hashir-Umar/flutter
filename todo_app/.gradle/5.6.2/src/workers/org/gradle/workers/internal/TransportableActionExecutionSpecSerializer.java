/*
 * Copyright 2019 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.gradle.workers.internal;

import org.gradle.internal.serialize.Decoder;
import org.gradle.internal.serialize.Encoder;
import org.gradle.internal.serialize.Serializer;

public class TransportableActionExecutionSpecSerializer implements Serializer<TransportableActionExecutionSpec> {
    private static final byte FLAT = (byte) 0;
    private static final byte HIERARCHICAL = (byte) 1;

    private final Serializer<HierarchicalClassLoaderStructure> hierarchicalClassLoaderStructureSerializer = new HierarchicalClassLoaderStructureSerializer();

    @Override
    public void write(Encoder encoder, TransportableActionExecutionSpec spec) throws Exception {
        encoder.writeString(spec.getDisplayName());
        encoder.writeString(spec.getImplementationClassName());
        encoder.writeInt(spec.getSerializedParameters().length);
        encoder.writeBytes(spec.getSerializedParameters());
        if (spec.getClassLoaderStructure() instanceof HierarchicalClassLoaderStructure) {
            encoder.writeByte(HIERARCHICAL);
            hierarchicalClassLoaderStructureSerializer.write(encoder, (HierarchicalClassLoaderStructure) spec.getClassLoaderStructure());
        } else if (spec.getClassLoaderStructure() instanceof FlatClassLoaderStructure) {
            encoder.writeByte(FLAT);
            // If the classloader structure is flat, there's no need to send the classpath
        } else {
            throw new IllegalArgumentException("Unknown classloader structure type: " + spec.getClassLoaderStructure().getClass().getSimpleName());
        }
    }

    @Override
    public TransportableActionExecutionSpec read(Decoder decoder) throws Exception {
        String displayName = decoder.readString();
        String implementationClassName = decoder.readString();
        int parametersSize = decoder.readInt();
        byte[] serializedParameters = new byte[parametersSize];
        decoder.readBytes(serializedParameters);
        byte classLoaderStructureTag = decoder.readByte();
        ClassLoaderStructure classLoaderStructure;
        switch(classLoaderStructureTag) {
            case FLAT:
                classLoaderStructure = new FlatClassLoaderStructure(null);
                break;
            case HIERARCHICAL:
                classLoaderStructure = hierarchicalClassLoaderStructureSerializer.read(decoder);
                break;
            default:
                throw new IllegalArgumentException("Unexpected payload type.");
        }
        return new TransportableActionExecutionSpec(displayName, implementationClassName, serializedParameters, classLoaderStructure);
    }
}
