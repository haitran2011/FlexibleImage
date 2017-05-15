//
//  InvertFilter.swift
//  Test Project
//
//  Created by Kawoou on 2017. 5. 12..
//  Copyright © 2017년 test. All rights reserved.
//

#if !os(watchOS)
    import Metal
#endif

internal class InvertFilter: ImageFilter {
    
    // MARK: - Property
    
    internal override var metalName: String {
        get {
            return "InvertFilter"
        }
    }
    
    
    // MARK: - Internal
    
    #if !os(watchOS)
        @available(OSX 10.11, iOS 8, tvOS 9, *)
        internal override func processMetal(_ device: ImageMetalDevice, _ commandBuffer: MTLCommandBuffer, _ commandEncoder: MTLComputeCommandEncoder) -> Bool {
            return super.processMetal(device, commandBuffer, commandEncoder)
        }
    #endif
    
    override func processNone(_ device: ImageNoneDevice) -> Bool {
        let memoryPool = device.memoryPool!
        let width = Int(device.drawRect!.width)
        let height = Int(device.drawRect!.height)
        
        var index = 0
        for _ in 0..<height {
            for _ in 0..<width {
                let r = memoryPool[index + 0]
                let g = memoryPool[index + 1]
                let b = memoryPool[index + 2]
                
                memoryPool[index + 0] = 255 - r
                memoryPool[index + 1] = 255 - g
                memoryPool[index + 2] = 255 - b
                
                index += 4
            }
        }
        
        return super.processNone(device)
    }
    
}
