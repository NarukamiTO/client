package alternativa.tanks.service.settings {
  import flash.events.IEventDispatcher;

  public interface ISettingsService extends IEventDispatcher {
    function get showDropZones() : Boolean;
    function set showDropZones(param1:Boolean) : void;
    function get showSkyBox() : Boolean;
    function get showFPS() : Boolean;
    function get showChat() : Boolean;
    function get mipMapping() : Boolean;
    function get inverseBackDriving() : Boolean;
    function get bgSound() : Boolean;
    function get muteSound() : Boolean;
    function set muteSound(param1:Boolean) : void;
    function get alternateCamera() : Boolean;
    function get showLocalDrone() : Boolean;
    function get receivePresents() : Boolean;
    function set receivePresents(param1:Boolean) : void;
    function get showRemoteDrones() : Boolean;
    function get adaptiveFPS() : Boolean;
    function get shadows() : Boolean;
    function get softParticles() : Boolean;
    function get dust() : Boolean;
    function get ssao() : Boolean;
    function get fog() : Boolean;
    function get dynamicLighting() : Boolean;
    function get antialiasing() : Boolean;
    function get dynamicShadows() : Boolean;
    function get graphicsAutoQuality() : Boolean;
    function get soundVolume() : Number;
    function set soundVolume(param1:Number) : void;
    function initSoundValue() : void;
    function get mouseControl() : Boolean;
    function getEmail() : String;
    function setEmail(param1:String, param2:Boolean) : void;
    function isEmailSet() : Boolean;
    function isNeedEmailRemind() : Boolean;
    function isEmailConfirmed() : Boolean;
    function setEmailConfirmed(param1:Boolean) : void;
    function get mouseSensitivity() : int;
    function get mouseYInverse() : Boolean;
    function get mouseYInverseShaftAim() : Boolean;
    function get isPasswordSet() : Boolean;
    function set isPasswordSet(param1:Boolean) : void;
    function get showDamage() : Boolean;
    function setClientSetting(param1:SettingEnum, param2:Object) : void;
  }
}
