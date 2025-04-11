package projects.tanks.client.chat.models.news.showing {
  public class NewsShowingCC {
    private var _newsItems:Vector.<NewsItemData>;

    public function NewsShowingCC(param1:Vector.<NewsItemData> = null) {
      super();
      this._newsItems = param1;
    }

    public function get newsItems() : Vector.<NewsItemData> {
      return this._newsItems;
    }

    public function set newsItems(param1:Vector.<NewsItemData>) : void {
      this._newsItems = param1;
    }

    public function toString() : String {
      var local1:String = "NewsShowingCC [";
      local1 += "newsItems = " + this.newsItems + " ";
      return local1 + "]";
    }
  }
}
