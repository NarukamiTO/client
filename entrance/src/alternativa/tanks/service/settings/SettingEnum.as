package alternativa.tanks.service.settings {
  import alternativa.tanks.AbstractEnum;

  public class SettingEnum extends AbstractEnum {
    public static const SHOW_SKY_BOX:SettingEnum = new SettingEnum(0,"showSkyBox");
    public static const SHOW_FPS:SettingEnum = new SettingEnum(1,"showFPS");
    public static const SHOW_CHAT:SettingEnum = new SettingEnum(2,"showChat");
    public static const ADAPTIVE_FPS:SettingEnum = new SettingEnum(3,"adaptiveFPS");
    public static const INVERSE_BACK_DRIVING:SettingEnum = new SettingEnum(4,"inverseBackDriving");
    public static const BG_SOUND:SettingEnum = new SettingEnum(5,"bgSound");
    public static const MUTE_SOUND:SettingEnum = new SettingEnum(6,"muteSound");
    public static const SOUND_VOLUME:SettingEnum = new SettingEnum(7,"volume");
    public static const MIPMAPPING:SettingEnum = new SettingEnum(8,"mipMapping");
    public static const ALTERNATE_CAMERA:SettingEnum = new SettingEnum(9,"alternateCamera");
    public static const SHADOWS_UNDER_TANK:SettingEnum = new SettingEnum(10,"shadows");
    public static const SOFT_PARTICLES:SettingEnum = new SettingEnum(11,"softParticles1");
    public static const DUST:SettingEnum = new SettingEnum(12,"dust");
    public static const FOG:SettingEnum = new SettingEnum(13,"fog");
    public static const SSAO:SettingEnum = new SettingEnum(14,"ssao");
    public static const DYNAMIC_SHADOWS:SettingEnum = new SettingEnum(15,"dynamicShadows");
    public static const GRAPHICS_AUTO_QUALITY:SettingEnum = new SettingEnum(16,"graphicsAutoQuality");
    public static const DYNAMIC_LIGHTING:SettingEnum = new SettingEnum(17,"dynamicLighting");
    public static const ANTIALIASING:SettingEnum = new SettingEnum(18,"antialiasing");
    public static const SHOW_DROP_ZONES:SettingEnum = new SettingEnum(19,"showDropZones");
    public static const MOUSE_CONTROL:SettingEnum = new SettingEnum(20,"mouseControl");
    public static const SHOW_DAMAGE:SettingEnum = new SettingEnum(21,"showDamage");
    public static const MOUSE_SENSITIVITY:SettingEnum = new SettingEnum(22,"mouseSensitivity");
    public static const MOUSE_Y_INVERSE:SettingEnum = new SettingEnum(23,"mouseYInverse");
    public static const MOUSE_Y_INVERSE_SHAFT_AIM:SettingEnum = new SettingEnum(24,"mouseYInverseShaftAim");
    public static const SHOW_LOCAL_DRONE:SettingEnum = new SettingEnum(25,"showLocalDrone");
    public static const SHOW_REMOTE_DRONES:SettingEnum = new SettingEnum(26,"showRemoteDrone");
    public static const RECEIVE_PRESENTS:SettingEnum = new SettingEnum(27,"receivePresents");

    public function SettingEnum(param1:int, param2:String) {
      super(param1,param2);
    }
  }
}
