package alternativa.tanks.models.drones {
  import alternativa.tanks.battle.scene3d.Renderer;

  public interface DroneRenderer extends Renderer {
    function stop() : void;
    function start() : void;
  }
}
