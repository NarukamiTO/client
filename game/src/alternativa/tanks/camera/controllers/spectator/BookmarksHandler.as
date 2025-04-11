package alternativa.tanks.camera.controllers.spectator {
  import alternativa.tanks.camera.CameraBookmark;
  import alternativa.tanks.camera.CameraBookmarks;
  import flash.events.KeyboardEvent;
  import flash.ui.Keyboard;
  import flash.utils.Dictionary;

  public class BookmarksHandler implements KeyboardHandler {
    private static const bookmarkKeys:Dictionary = createKeyMap();

    private const bookmarks:CameraBookmarks = new CameraBookmarks(10);

    private var listener:BookmarkListener;

    public function BookmarksHandler() {
      super();
    }

    private static function createKeyMap() : Dictionary {
      var local1:Dictionary = new Dictionary();
      local1[Keyboard.NUMBER_0] = 0;
      local1[Keyboard.NUMBER_1] = 1;
      local1[Keyboard.NUMBER_2] = 2;
      local1[Keyboard.NUMBER_3] = 3;
      local1[Keyboard.NUMBER_4] = 4;
      local1[Keyboard.NUMBER_5] = 5;
      local1[Keyboard.NUMBER_6] = 6;
      local1[Keyboard.NUMBER_7] = 7;
      local1[Keyboard.NUMBER_8] = 8;
      local1[Keyboard.NUMBER_9] = 9;
      return local1;
    }

    public function setListener(param1:BookmarkListener) : void {
      this.listener = param1;
    }

    public function handleKeyDown(param1:KeyboardEvent) : void {
      var local2:* = bookmarkKeys[param1.keyCode];
      if(local2 != null) {
        if(param1.ctrlKey) {
          this.saveCurrentPositionCameraToBookmark(local2);
        } else {
          this.goToBookmark(local2);
        }
      }
    }

    public function handleKeyUp(param1:KeyboardEvent) : void {
    }

    private function saveCurrentPositionCameraToBookmark(param1:int) : void {
      this.bookmarks.saveCurrentPositionCameraToBookmark(param1);
    }

    private function goToBookmark(param1:int) : void {
      var local2:CameraBookmark = this.bookmarks.getBookmark(param1);
      if(local2 != null && this.listener != null) {
        this.listener.onBookmarkSelected(local2);
      }
    }
  }
}
