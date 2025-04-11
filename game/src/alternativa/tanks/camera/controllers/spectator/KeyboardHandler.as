package alternativa.tanks.camera.controllers.spectator {
  import flash.events.KeyboardEvent;

  public interface KeyboardHandler {
    function handleKeyDown(param1:KeyboardEvent) : void;
    function handleKeyUp(param1:KeyboardEvent) : void;
  }
}
