cask "plex" do
  version "1.58.1.3380,ea159c52"
  sha256 "60bd627b8f6dbff66871334a4d7aa721f4f742d6d1e562e17354a07023df7cf7"

  url "https://downloads.plex.tv/plex-desktop/#{version.csv.first}-#{version.csv.second}/macos/Plex-#{version.csv.first}-#{version.csv.second}-x86_64.zip"
  name "Plex"
  desc "Home media player"
  homepage "https://www.plex.tv/"

  livecheck do
    url "https://plex.tv/api/downloads/6.json"
    regex(/"version"\s*:\s*"(\d(?:\.\d+)*)-([a-f0-9]{8})"/i)
    strategy :page_match do |page, regex|
      page.scan(regex).map { |match| "#{match[0]},#{match[1]}" }
    end
  end

  auto_updates true
  depends_on macos: ">= :high_sierra"

  app "Plex.app"

  zap trash: [
    "~/Library/Application Support/Plex",
    "~/Library/Caches/Plex",
    "~/Library/Logs/Plex",
  ]
end
