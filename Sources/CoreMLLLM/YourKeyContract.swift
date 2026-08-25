// YourKeyContract.swift — the EXACT call shapes Your Key's native module
// (modules/coreml-tier) makes against this package, compiled by CI so an API
// drift is a compile error here — on the free runner — never a burned EAS
// build credit. Never called at runtime.
import Foundation

@available(iOS 18.0, macOS 15.0, *)
internal enum YourKeyContract {
    static func typecheck() async throws {
        // The default path: the registered model table, by slug.
        let byRepo = try await CoreMLLLM.load(repo: "qwen2.5-0.5b")
        _ = try await byRepo.generate("prompt", maxTokens: 64)

        // The re-host path: a caller-supplied URL (Your Key's R2), so hosting
        // can change from JavaScript forever — no rebuild.
        let info = ModelDownloader.ModelInfo(
            id: "qwen2.5-0.5b", name: "Qwen2.5 0.5B (Text)", size: "309 MB",
            downloadURL: "https://example.com/qwen2.5-0.5b-coreml.zip",
            folderName: "qwen2.5-0.5b")
        let byInfo = try await CoreMLLLM.load(model: info)
        _ = try await byInfo.generate("prompt", maxTokens: 64)
    }
}
