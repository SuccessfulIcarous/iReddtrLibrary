    import XCTest
    @testable import iReddtrLibrary

    final class iReddtrLibraryTests: XCTestCase {
        func proxyLibraryShouldHaveProxyUrl() {
            // This is an example of a functional test case.
            // Use XCTAssert and related functions to verify your tests produce the correct
            // results.
            let library = iReddtr.getProxiedAPI()
            XCTAssertEqual(library.baseUrl, "https://asia-southeast2-macredditbackend.cloudfunctions.net/reddit/v1")
        }
        
        func nonProxyLibraryShouldHaveRedditUrl() {
            let library = iReddtr.getAPI()
            XCTAssertEqual(library.baseUrl, "https://www.reddit.com")
        }
        
        func mapMediaUrlCorrectly() {
            let urlStrings = [
                "https://styles.redditmedia.com/t5_2s113/styles/communityIcon_sin7zgewtag01.png?width=256&amp;s=a40cbf01bb96c1c765fd6da751ab9a5b7b02d65e",
                "https://a.thumbs.redditmedia.com/pwaSmUVd1vsucuDlyD5mzWGO65vpWt96Tp1CIwBbbX4.png",
                "https://b.thumbs.redditmedia.com/8pNB3vgvs6FPdvYh2qgsrC8noL-ExDIsfFb7-mYoZOM.png",
                "https://c.thumbs.redditmedia.com/Py8PcuzsDRBiKuun.png",
                "https://d.thumbs.redditmedia.com/44bZNXxzsoEJE-2o.png",
                "https://e.thumbs.redditmedia.com/klRicnC-SxJWSeEF.png",
                "https://f.thumbs.redditmedia.com/cs2TTatQm0c-pPOk.png",
                "https://g.thumbs.redditmedia.com/cs2TTatQm0c-pPOk.png"
            ]
            let expectedUrlStrings = [
                "https://asia-southeast2-macredditbackend.cloudfunctions.net/reddit/v1/styles/t5_2s113/styles/communityIcon_sin7zgewtag01.png?width=256&s=a40cbf01bb96c1c765fd6da751ab9a5b7b02d65e",
                "https://asia-southeast2-macredditbackend.cloudfunctions.net/reddit/v1/athumbs/pwaSmUVd1vsucuDlyD5mzWGO65vpWt96Tp1CIwBbbX4.png",
                "https://asia-southeast2-macredditbackend.cloudfunctions.net/reddit/v1/bthumbs/8pNB3vgvs6FPdvYh2qgsrC8noL-ExDIsfFb7-mYoZOM.png",
                "https://asia-southeast2-macredditbackend.cloudfunctions.net/reddit/v1/cthumbs/Py8PcuzsDRBiKuun.png",
                "https://asia-southeast2-macredditbackend.cloudfunctions.net/reddit/v1/dthumbs/44bZNXxzsoEJE-2o.png",
                "https://asia-southeast2-macredditbackend.cloudfunctions.net/reddit/v1/ethumbs/klRicnC-SxJWSeEF.png",
                "https://asia-southeast2-macredditbackend.cloudfunctions.net/reddit/v1/fthumbs/cs2TTatQm0c-pPOk.png",
                "https://asia-southeast2-macredditbackend.cloudfunctions.net/reddit/v1/gthumbs/cs2TTatQm0c-pPOk.png"
            ]
            for (index, _) in urlStrings.enumerated() {
                XCTAssertEqual(urlStrings[index], expectedUrlStrings[index])
            }
        }
    }
