package alternativa.tanks.service.logging {
  import alternativa.osgi.OSGi;
  import alternativa.tanks.service.settings.ISettingsService;
  import alternativa.tanks.service.settings.SettingsServiceEvent;
  import flash.events.EventDispatcher;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.settings.UserSettingsChangedEvent;
  import projects.tanks.clients.fp10.libraries.tanksservices.service.logging.settings.UserSettingsChangedService;

  public class UserSettingsChangedServiceImpl extends EventDispatcher implements UserSettingsChangedService {
    private var settings:ISettingsService;

    private const PARAM_SHOW_SKY_BOX:int = 1 << 0;
    private const PARAM_SHOW_FPS:int = 1 << 1;
    private const PARAM_SHOW_CHAT:int = 1 << 2;
    private const PARAM_ADAPTIVE_FPS:int = 1 << 3;
    private const PARAM_INVERSE_BACK_DRIVING:int = 1 << 4;
    private const PARAM_BGSOUND:int = 1 << 5;
    private const PARAM_MUTE_SOUND:int = 1 << 6;
    private const PARAM_MIPMAPPING:int = 1 << 7;
    private const PARAM_ALTERNATE_CAMERA:int = 1 << 8;
    private const PARAM_SHADOWS:int = 1 << 9;
    private const PARAM_SOFT_PARTICLES:int = 1 << 10;
    private const PARAM_DUST:int = 1 << 11;
    private const PARAM_FOG:int = 1 << 12;
    private const PARAM_SSAO:int = 1 << 13;
    private const PARAM_DYNAMIC_SHADOWS:int = 1 << 14;
    private const PARAM_GRAPHICS_AUTO_QUALITY:int = 1 << 15;
    private const PARAM_DYNAMIC_LIGHTING:int = 1 << 16;
    private const PARAM_ANTIALIASING:int = 1 << 17;
    private const PARAM_SHOW_DROP_ZONES:int = 1 << 18;
    private const PARAM_MOUSE_CONTROL:int = 1 << 19;

    public function UserSettingsChangedServiceImpl() {
      super();
      this.settings = ISettingsService(OSGi.getInstance().getService(ISettingsService));
      this.settings.addEventListener(SettingsServiceEvent.SETTINGS_CHANGED,this.settingsAccepted);
    }

    private function settingsAccepted(param1:SettingsServiceEvent) : void {
      var local2:int = 0;
      if(this.settings.showSkyBox) {
        local2 |= this.PARAM_SHOW_SKY_BOX;
      }
      if(this.settings.showFPS) {
        local2 |= this.PARAM_SHOW_FPS;
      }
      if(this.settings.showChat) {
        local2 |= this.PARAM_SHOW_CHAT;
      }
      if(this.settings.adaptiveFPS) {
        local2 |= this.PARAM_ADAPTIVE_FPS;
      }
      if(this.settings.inverseBackDriving) {
        local2 |= this.PARAM_INVERSE_BACK_DRIVING;
      }
      if(this.settings.bgSound) {
        local2 |= this.PARAM_BGSOUND;
      }
      if(this.settings.muteSound) {
        local2 |= this.PARAM_MUTE_SOUND;
      }
      if(this.settings.mipMapping) {
        local2 |= this.PARAM_MIPMAPPING;
      }
      if(this.settings.alternateCamera) {
        local2 |= this.PARAM_ALTERNATE_CAMERA;
      }
      if(this.settings.shadows) {
        local2 |= this.PARAM_SHADOWS;
      }
      if(this.settings.softParticles) {
        local2 |= this.PARAM_SOFT_PARTICLES;
      }
      if(this.settings.dust) {
        local2 |= this.PARAM_DUST;
      }
      if(this.settings.fog) {
        local2 |= this.PARAM_FOG;
      }
      if(this.settings.ssao) {
        local2 |= this.PARAM_SSAO;
      }
      if(this.settings.dynamicShadows) {
        local2 |= this.PARAM_DYNAMIC_SHADOWS;
      }
      if(this.settings.graphicsAutoQuality) {
        local2 |= this.PARAM_GRAPHICS_AUTO_QUALITY;
      }
      if(this.settings.dynamicLighting) {
        local2 |= this.PARAM_DYNAMIC_LIGHTING;
      }
      if(this.settings.antialiasing) {
        local2 |= this.PARAM_ANTIALIASING;
      }
      if(this.settings.showDropZones) {
        local2 |= this.PARAM_SHOW_DROP_ZONES;
      }
      if(this.settings.mouseControl) {
        local2 |= this.PARAM_MOUSE_CONTROL;
      }
      dispatchEvent(new UserSettingsChangedEvent(local2));
    }
  }
}
