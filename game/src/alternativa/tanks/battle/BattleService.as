package alternativa.tanks.battle {
  import alternativa.math.Vector3;
  import alternativa.tanks.battle.scene3d.BattleScene3D;
  import alternativa.tanks.camera.CameraController;
  import alternativa.tanks.camera.CameraTarget;
  import alternativa.tanks.models.weapon.ricochet.RicochetTargetEvaluator;
  import alternativa.tanks.models.weapon.shared.CommonTargetEvaluator;
  import alternativa.tanks.models.weapon.shared.ConicAreaTargetValidator;
  import alternativa.tanks.models.weapon.shared.HealingGunTargetEvaluator;
  import alternativa.tanks.models.weapon.shared.RailgunTargetEvaluator;
  import alternativa.tanks.sfx.GraphicEffect;
  import alternativa.tanks.sfx.ISound3DEffect;
  import alternativa.tanks.sound.ISoundManager;
  import alternativa.tanks.utils.objectpool.ObjectPool;
  import flash.display.BitmapData;
  import flash.media.Sound;
  import flash.utils.Dictionary;
  import platform.client.fp10.core.type.IGameObject;

  public interface BattleService {
    function getObjectPool() : ObjectPool;
    function getBattleRunner() : BattleRunner;
    function getBattleScene3D() : BattleScene3D;
    function getBattleView() : BattleView;
    function getCommonTargetEvaluator() : CommonTargetEvaluator;
    function setCommonTargetEvaluator(param1:CommonTargetEvaluator) : void;
    function getConicAreaTargetValidator() : ConicAreaTargetValidator;
    function getHealingGunTargetEvaluator() : HealingGunTargetEvaluator;
    function setHealingGunTargetEvaluator(param1:HealingGunTargetEvaluator) : void;
    function getRailgunTargetEvaluator() : RailgunTargetEvaluator;
    function setRailgunTargetEvaluator(param1:RailgunTargetEvaluator) : void;
    function getIdleKickPeriod() : int;
    function getTankExplosionSound() : Sound;
    function get soundManager() : ISoundManager;
    function setFollowCameraTarget(param1:CameraTarget) : void;
    function addGraphicEffect(param1:GraphicEffect) : void;
    function addSound3DEffect(param1:ISound3DEffect) : void;
    function setCameraController(param1:CameraController) : void;
    function activateFollowCamera() : void;
    function lockFollowCamera() : void;
    function unlockFollowCamera() : void;
    function setFollowCameraState(param1:Vector3, param2:Vector3) : void;
    function activateFlyCamera(param1:Vector3, param2:Vector3) : void;
    function isBattleActive() : Boolean;
    function getExcludedObjects3D() : Dictionary;
    function getRicochetTargetEvaluator() : RicochetTargetEvaluator;
    function setRicochetTargetEvaluator(param1:RicochetTargetEvaluator) : void;
    function setBillboardImage(param1:BitmapData) : void;
    function unlockBattle() : void;
    function getPhysicsTime() : int;
    function setLocalTankLoaded() : void;
    function isLocalTankFirstLoad() : Boolean;
    function getRespawnDurationMs() : int;
    function isLocalTankPaused() : Boolean;
    function setLocalTankPaused(param1:Boolean) : void;
    function getBattle() : IGameObject;
  }
}
