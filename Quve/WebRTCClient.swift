//
//  WebRTCClient.swift
//  Quve
//
//  Created by ParkSungJoon on 15/12/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import Foundation

protocol WebRTCClientDelegate: class {
    func webRTCClient(_ client: WebRTCClient, didDiscoverLocalCandidate candidate: RTCIceCandidate)
}

class WebRTCClient: NSObject {
    
    var factory: RTCPeerConnectionFactory
    var peerConnection: RTCPeerConnection
    var localCandidates = [RTCIceCandidate]()
    private let mediaConstrains = [kRTCMediaConstraintsOfferToReceiveAudio: kRTCMediaConstraintsValueTrue,
                                   kRTCMediaConstraintsOfferToReceiveVideo: kRTCMediaConstraintsValueTrue
                                   ]
    
    private var videoCapturer: RTCVideoCapturer?
    private var remoteStream: RTCMediaStream?
    private var localVideoTrack: RTCVideoTrack?
    
    weak var delegate: WebRTCClientDelegate?
    
    override init() {
        let videoEncoderFactory = RTCDefaultVideoEncoderFactory()
        let videoDecoderFactory = RTCDefaultVideoDecoderFactory()
        factory = RTCPeerConnectionFactory(encoderFactory: videoEncoderFactory, decoderFactory: videoDecoderFactory)
        
        let constraints = RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: ["DtlsSrtpKeyAgreement":kRTCMediaConstraintsValueTrue])
        let config = RTCConfiguration()
        config.iceServers = [RTCIceServer(urlStrings: ["stun:stun.l.google.com:19302"])]
        config.sdpSemantics = .unifiedPlan
        config.continualGatheringPolicy = .gatherContinually
        peerConnection = factory.peerConnection(with: config, constraints: constraints, delegate: nil)
        
        super.init()
        createMediaSenders()
        peerConnection.delegate = self
    }
    
    //MARK: Create Offer Session Description Protocol
    func createOffer(completion: @escaping (_ sdp: RTCSessionDescription) -> ()){
        let constraints = RTCMediaConstraints(mandatoryConstraints: self.mediaConstrains, optionalConstraints: nil)
        peerConnection.offer(for: constraints) { (sdp, error) in
            guard let sdp = sdp else { return }
            self.peerConnection.setLocalDescription(sdp, completionHandler: { (error) in
                completion(sdp)
            })
        }
    }
    
    //MARK: Create Offer Session Description Protocol
    func createAnswer(completion: @escaping (_ sdp: RTCSessionDescription) -> ()){
        let constraints = RTCMediaConstraints(mandatoryConstraints: self.mediaConstrains, optionalConstraints: nil)
        peerConnection.answer(for: constraints) { (sdp, error) in
            guard let sdp = sdp else { return }
            self.peerConnection.setLocalDescription(sdp, completionHandler: { (error) in
                completion(sdp)
            })
        }
    }
    
    //MARK: Apply the supplied RTCSessionDescription as the remote description
    func set(remoteSdp: RTCSessionDescription, completion: @escaping (_ error: Error?) -> ()){
        peerConnection.setRemoteDescription(remoteSdp, completionHandler: completion)
    }
    
    //MARK: Provide a remote candidate to the ICE Agent
    func set(remoteCandidate: RTCIceCandidate){
        peerConnection.add(remoteCandidate)
    }
    
    //MARK: Starts the capture session asynchronously
    func startCaptureLocalVideo(renderer: RTCVideoRenderer){
        guard let capturer = videoCapturer as? RTCCameraVideoCapturer else { return }
        guard
            let frontCamera = (RTCCameraVideoCapturer.captureDevices().first { $0.position == .front }),
            let format = (RTCCameraVideoCapturer.supportedFormats(for: frontCamera).sorted(by: { (f1, f2) -> Bool in
                let width1 = CMVideoFormatDescriptionGetDimensions(f1.formatDescription).width
                let width2 = CMVideoFormatDescriptionGetDimensions(f2.formatDescription).width
                return width1 < width2
            }).last),
            let fps = (format.videoSupportedFrameRateRanges.sorted { return $0.maxFrameRate < $1.maxFrameRate }.last)
        else { return }
        
        capturer.startCapture(with: frontCamera, format: format, fps: Int(fps.maxFrameRate))
        localVideoTrack?.add(renderer)
    }
    
    func renderRemoteVideo(to renderer: RTCVideoRenderer){
        remoteStream?.videoTracks.first?.add(renderer)
    }
    
    func muteAudio(){
        setAudioEnabled(false)
    }
    
    func unmuteAudio(){
        setAudioEnabled(true)
    }
    
    //MARK: Add a new media stream track to be sent on this peer connection
    fileprivate func createMediaSenders(){
        let audioTrack = createAudioTrack()
        let videoTrack = createVideoTrack()
        peerConnection.add(audioTrack, streamIds: ["stream0"])
        peerConnection.add(videoTrack, streamIds: ["stream0"])
        localVideoTrack = videoTrack
    }
    
    
    fileprivate func setAudioEnabled(_ isEnabled: Bool){
        let audioTracks = peerConnection.senders.compactMap { return $0.track as? RTCAudioTrack }
        audioTracks.forEach { $0.isEnabled = isEnabled }
    }
    
    //MARK: Initialize an RTCAudioTrack with a source and an id
    fileprivate func createAudioTrack() -> RTCAudioTrack{
        let audioConstraints = RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: nil)
        let audioSource = factory.audioSource(with: audioConstraints)
        let audioTrack = factory.audioTrack(with: audioSource, trackId: "audio0")
        return audioTrack
    }
    
    //MARK: Initialize an RTCVideoTrack with a source and an id
    fileprivate func createVideoTrack() -> RTCVideoTrack{
        let videoSource = factory.videoSource()
        videoCapturer = RTCCameraVideoCapturer(delegate: videoSource)
        let videoTrack = factory.videoTrack(with: videoSource, trackId: "video0")
        return videoTrack
    }
}

extension WebRTCClient: RTCPeerConnectionDelegate{
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didChange stateChanged: RTCSignalingState) {
        print("peerConnection new signaling state: \(stateChanged)")
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didAdd stream: RTCMediaStream) {
        self.remoteStream = stream
        print("peerConnection did add stream")
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove stream: RTCMediaStream) {
        print("peerConnection did remote stream")
    }
    
    func peerConnectionShouldNegotiate(_ peerConnection: RTCPeerConnection) {
        print("peerConnection should negotiate")
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceConnectionState) {
        print("peerConnection new connection state: \(newState)")
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceGatheringState) {
        print("peerConnection new gathering state: \(newState)")
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didGenerate candidate: RTCIceCandidate) {
        self.localCandidates.append(candidate)
        self.delegate?.webRTCClient(self, didDiscoverLocalCandidate: candidate)
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove candidates: [RTCIceCandidate]) {
        print("peerConnection did remove data channel")
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didOpen dataChannel: RTCDataChannel) {
        print("peerConnection did open data channel")
    }
}
