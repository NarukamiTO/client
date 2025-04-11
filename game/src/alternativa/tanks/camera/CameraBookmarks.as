package alternativa.tanks.camera {
  public class CameraBookmarks {
    private var bookmarks:Vector.<CameraBookmark>;

    public function CameraBookmarks(param1:int) {
      super();
      this.bookmarks = new Vector.<CameraBookmark>(param1);
    }

    public function getBookmark(param1:uint) : CameraBookmark {
      if(param1 < this.bookmarks.length) {
        return this.bookmarks[param1];
      }
      return null;
    }

    public function saveCurrentPositionCameraToBookmark(param1:uint) : void {
      if(param1 < this.bookmarks.length) {
        this.getOrCreateBookmark(param1).saveCurrentPossitionCamera();
      }
    }

    private function getOrCreateBookmark(param1:uint) : CameraBookmark {
      if(this.bookmarks[param1] == null) {
        this.bookmarks[param1] = new CameraBookmark();
      }
      return this.bookmarks[param1];
    }
  }
}
