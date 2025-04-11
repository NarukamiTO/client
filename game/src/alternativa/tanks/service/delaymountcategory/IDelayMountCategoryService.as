package alternativa.tanks.service.delaymountcategory {
  import controls.timer.CountDownTimer;
  import platform.client.fp10.core.type.IGameObject;
  import projects.tanks.client.garage.models.item.delaymount.DelayMountCategoryCC;

  public interface IDelayMountCategoryService {
    function getDownTimer(param1:IGameObject) : CountDownTimer;
    function createTimers(param1:DelayMountCategoryCC) : void;
    function destroyTimers() : void;
    function resetTimers() : void;
  }
}
