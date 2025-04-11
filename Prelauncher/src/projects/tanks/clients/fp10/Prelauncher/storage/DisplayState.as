package projects.tanks.clients.fp10.Prelauncher.storage {
  public class DisplayState {
    public var x:int;
    public var y:int;
    public var width:int;
    public var height:int;
    public var fullscreen:Boolean;

    public function DisplayState(x:int, y:int, width:int, height:int, fullscreen:Boolean) {
      super();
      this.x = x;
      this.y = y;
      this.width = width;
      this.height = height;
      this.fullscreen = fullscreen;
    }
  }
}
