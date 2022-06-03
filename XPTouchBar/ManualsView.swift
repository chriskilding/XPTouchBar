import SwiftUI
import AppKit
import PDFKit

struct ManualsView: View {
    
    var manuals: [Manual] {
        return [
            Manual(title: "Beechcraft Baron 58", url: URL(string: "https://x-plane.com/manuals/Baron_Pilot_Operating_Manual.pdf")),
            Manual(title: "Boeing 737-800", url: URL(string: "https://x-plane.com/manuals/737_Pilot_Operating_Manual.pdf")),
            Manual(title: "Boeing 747-400", url: URL(string: "https://x-plane.com/manuals/B747_Pilot_Operating_Manual.pdf")),
            Manual(title: "Cessna 172", url: URL(string: "https://www.x-plane.com/manuals/C172_Pilot_Operating_Manual.pdf")),
            Manual(title: "Cirrus Vision SF50", url: URL(string: "https://www.x-plane.com/manuals/SF50_Pilot_Operating_Manual.pdf")),
            Manual(title: "King Air C90B", url: URL(string: "https://x-plane.com/manuals/C90B_Pilot_Operating_Manual.pdf")),
            Manual(title: "McDonnell Douglas MD-82", url: URL(string: "https://x-plane.com/manuals/MD-82_Pilot_Operating_Manual.pdf")),
            Manual(title: "S-TEC 55", url: URL(string: "https://www.x-plane.com/manuals/S-TEC_Autopilot_Manual.pdf")),
            Manual(title: "X-Plane G430", url: URL(string: "https://x-plane.com/manuals/G430_Manual.pdf")),
            Manual(title: "X-Plane G530", url: URL(string: "https://x-plane.com/manuals/G530_Manual.pdf")),
            Manual(title: "X-Plane G1000", url: URL(string: "https://x-plane.com/manuals/G1000_Manual.pdf")),
            Manual(title: "X-Plane FMS", url: URL(string: "https://x-plane.com/manuals/FMS_Manual.pdf"))
            
        ].sorted(using: sortOrder)
    }
        
    @State private var sortOrder = [KeyPathComparator(\Manual.title)]
    
    private func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
    
    var body: some View {
        NavigationView {
            List(manuals, id: \.id) { manual in
                NavigationLink(destination: ManualView(manual: manual)) {
                    Text(manual.title)
                }
            }
            .listStyle(.sidebar)
            
            Text("Select a manual to view")
        }
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: toggleSidebar, label: {
                    Image(systemName: "sidebar.leading")
                })
            }
        }
    }
}

struct ManualView: View {
    
    let manual: Manual
    
    var body: some View {
        PDFViewRepresentable(url: manual.url)
    }
}

struct ManualsView_Previews: PreviewProvider {
    static var previews: some View {
        ManualsView()
    }
}

struct Manual: Identifiable {
    let title: String
    let url: URL?
    let id = UUID()
}

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
