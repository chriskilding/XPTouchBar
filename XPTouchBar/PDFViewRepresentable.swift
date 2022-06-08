import SwiftUI
import PDFKit

struct PDFViewRepresentable : NSViewRepresentable {

    let url: URL?
    
    init(url : URL?) {
        self.url = url
    }

    func makeNSView(context: Context) -> NSView {
        let pdfView = PDFView()
        pdfView.acceptsDraggedFiles = false
        pdfView.autoScales = true
        pdfView.displayMode = .singlePageContinuous

        if let url = url {
            pdfView.document = PDFDocument(url: url)
        }

        return pdfView
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        // Empty
    }

}
