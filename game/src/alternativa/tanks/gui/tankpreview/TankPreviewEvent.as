package alternativa.tanks.gui.tankpreview {
  public class TankPreviewEvent {
    public static const MOUSE_DOWN:TankPreviewEvent = new TankPreviewEvent();
    public static const STOP_MANUAL_ROTATION:TankPreviewEvent = new TankPreviewEvent();
    public static const ROTATION_STOPPED:TankPreviewEvent = new TankPreviewEvent();
    public static const IDLE_STATE_TIMEOUT:TankPreviewEvent = new TankPreviewEvent();

    public function TankPreviewEvent() {
      super();
    }
  }
}
