package alternativa.tanks.service.settings {
  import flash.events.EventDispatcher;
  import flash.media.SoundMixer;
  import flash.media.SoundTransform;
  import flash.net.SharedObject;
  import projects.tanks.clients.flash.commons.models.gpu.GPUCapabilities;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.friend.battleinvite.IBattleInviteService;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.storage.IStorageService;

  public class SettingsService extends EventDispatcher implements ISettingsService {
    [Inject]
    public static var storageService:IStorageService;

    [Inject]
    public static var battleInviteService:IBattleInviteService;

    private static const DEFAULT_VOLUME:Number = 0.7;
    private static const DEFAULT_MOUSE_SENSITIVE:int = 8;

    private var email:String;
    private var emailConfirmed:Boolean;
    private var _isPasswordSet:Boolean = false;

    public function SettingsService() {
      super();
    }

    private static function updateSoundValue(param1:Boolean, param2:Number) : void {
      SoundMixer.soundTransform = new SoundTransform(param1 ? 0 : param2);
    }

    public function get showDropZones() : Boolean {
      return this.getBoolean(SettingEnum.SHOW_DROP_ZONES,true);
    }

    public function set showDropZones(param1:Boolean) : void {
      this.setClientSetting(SettingEnum.SHOW_DROP_ZONES,param1);
    }

    public function get showSkyBox() : Boolean {
      return this.getBoolean(SettingEnum.SHOW_SKY_BOX,true);
    }

    public function get showFPS() : Boolean {
      return this.getBoolean(SettingEnum.SHOW_FPS,true);
    }

    public function get showChat() : Boolean {
      return this.getBoolean(SettingEnum.SHOW_CHAT,true);
    }

    public function get mipMapping() : Boolean {
      return this.getBoolean(SettingEnum.MIPMAPPING,true);
    }

    public function get alternateCamera() : Boolean {
      return this.getBoolean(SettingEnum.ALTERNATE_CAMERA,false);
    }

    public function get adaptiveFPS() : Boolean {
      return this.getBoolean(SettingEnum.ADAPTIVE_FPS,false);
    }

    public function get inverseBackDriving() : Boolean {
      return this.getBoolean(SettingEnum.INVERSE_BACK_DRIVING,false);
    }

    public function get bgSound() : Boolean {
      return this.getBoolean(SettingEnum.BG_SOUND,true);
    }

    public function get muteSound() : Boolean {
      return this.getBoolean(SettingEnum.MUTE_SOUND,false);
    }

    public function set muteSound(param1:Boolean) : void {
      SettingsService.updateSoundValue(param1,this.soundVolume);
      this.setClientSetting(SettingEnum.MUTE_SOUND,param1);
    }

    public function get shadows() : Boolean {
      return GPUCapabilities.gpuEnabled && !GPUCapabilities.constrained && this.getBoolean(SettingEnum.SHADOWS_UNDER_TANK,true);
    }

    public function get softParticles() : Boolean {
      return GPUCapabilities.gpuEnabled && !GPUCapabilities.constrained && this.getBoolean(SettingEnum.SOFT_PARTICLES,false);
    }

    public function get dust() : Boolean {
      return GPUCapabilities.gpuEnabled && !GPUCapabilities.constrained && this.getBoolean(SettingEnum.SOFT_PARTICLES,false) && this.getBoolean(SettingEnum.DUST,false);
    }

    public function get ssao() : Boolean {
      return GPUCapabilities.gpuEnabled && !GPUCapabilities.constrained && this.getBoolean(SettingEnum.SSAO,false);
    }

    public function get fog() : Boolean {
      return GPUCapabilities.gpuEnabled && !GPUCapabilities.constrained && this.getBoolean(SettingEnum.FOG,true);
    }

    public function get dynamicShadows() : Boolean {
      return GPUCapabilities.gpuEnabled && !GPUCapabilities.constrained && this.getBoolean(SettingEnum.DYNAMIC_SHADOWS,false);
    }

    public function get dynamicLighting() : Boolean {
      var local1:Boolean = this.dynamicShadows || this.ssao || this.softParticles;
      return GPUCapabilities.gpuEnabled && !GPUCapabilities.constrained && this.getBoolean(SettingEnum.DYNAMIC_LIGHTING,local1);
    }

    public function get antialiasing() : Boolean {
      return GPUCapabilities.gpuEnabled && !GPUCapabilities.constrained && this.getBoolean(SettingEnum.ANTIALIASING,false);
    }

    public function get graphicsAutoQuality() : Boolean {
      if(this.settingExists(SettingEnum.GRAPHICS_AUTO_QUALITY)) {
        return GPUCapabilities.gpuEnabled && !GPUCapabilities.constrained && this.getBoolean(SettingEnum.GRAPHICS_AUTO_QUALITY,false);
      }
      return GPUCapabilities.gpuEnabled && !GPUCapabilities.constrained;
    }

    private function settingExists(param1:SettingEnum) : Boolean {
      return storageService.getStorage().data[param1.name] != null;
    }

    public function get soundVolume() : Number {
      return this.getNumber(SettingEnum.SOUND_VOLUME,DEFAULT_VOLUME);
    }

    public function set soundVolume(param1:Number) : void {
      updateSoundValue(this.muteSound,param1);
      this.setClientSetting(SettingEnum.SOUND_VOLUME,param1);
    }

    public function initSoundValue() : void {
      updateSoundValue(this.muteSound,this.soundVolume);
    }

    private function getBoolean(param1:SettingEnum, param2:Boolean) : Boolean {
      var local3:* = storageService.getStorage().data[param1.name];
      return local3 == null ? param2 : local3;
    }

    private function storeBoolean(param1:SettingEnum, param2:Boolean) : void {
      storageService.getStorage().data[param1.name] = param2;
    }

    private function getNumber(param1:SettingEnum, param2:Number = 0) : Number {
      var local3:Number = Number(storageService.getStorage().data[param1.name]);
      return isNaN(local3) ? param2 : local3;
    }

    private function storeNumber(param1:SettingEnum, param2:Number) : void {
      storageService.getStorage().data[param1.name] = param2;
    }

    public function setEmail(param1:String, param2:Boolean) : void {
      this.email = param1;
      this.emailConfirmed = param2;
    }

    public function isEmailSet() : Boolean {
      return this.email != null && this.email != "";
    }

    public function isNeedEmailRemind() : Boolean {
      return !this.isEmailConfirmed();
    }

    public function getEmail() : String {
      return this.email != null ? this.email : "";
    }

    public function isEmailConfirmed() : Boolean {
      return this.emailConfirmed;
    }

    public function setEmailConfirmed(param1:Boolean) : void {
      this.emailConfirmed = param1;
    }

    public function get mouseControl() : Boolean {
      return this.getBoolean(SettingEnum.MOUSE_CONTROL,true);
    }

    public function get mouseSensitivity() : int {
      return this.getNumber(SettingEnum.MOUSE_SENSITIVITY,DEFAULT_MOUSE_SENSITIVE);
    }

    public function get mouseYInverse() : Boolean {
      return this.getBoolean(SettingEnum.MOUSE_Y_INVERSE,false);
    }

    public function get mouseYInverseShaftAim() : Boolean {
      return this.getBoolean(SettingEnum.MOUSE_Y_INVERSE_SHAFT_AIM,false);
    }

    public function get isPasswordSet() : Boolean {
      return this._isPasswordSet;
    }

    public function set isPasswordSet(param1:Boolean) : void {
      this._isPasswordSet = param1;
    }

    public function get showDamage() : Boolean {
      return this.getBoolean(SettingEnum.SHOW_DAMAGE,true);
    }

    public function setClientSetting(param1:SettingEnum, param2:Object) : void {
      var local3:SharedObject = storageService.getStorage();
      local3.data[param1.name] = param2;
      local3.flush();
      dispatchEvent(new SettingsServiceEvent(SettingsServiceEvent.SETTINGS_CHANGED,param1));
    }

    public function get showLocalDrone() : Boolean {
      return this.getBoolean(SettingEnum.SHOW_LOCAL_DRONE,true);
    }

    public function get showRemoteDrones() : Boolean {
      return this.getBoolean(SettingEnum.SHOW_REMOTE_DRONES,true);
    }

    public function get receivePresents() : Boolean {
      return this.getBoolean(SettingEnum.RECEIVE_PRESENTS,false);
    }

    public function set receivePresents(param1:Boolean) : void {
      var local2:SharedObject = storageService.getStorage();
      local2.data[SettingEnum.RECEIVE_PRESENTS] = param1;
    }
  }
}
