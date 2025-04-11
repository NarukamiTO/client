package projects.tanks.client.achievements.osgi {
  import _codec.projects.tanks.client.achievements.model.CodecAchievement;
  import _codec.projects.tanks.client.achievements.model.VectorCodecAchievementLevel1;
  import _codec.projects.tanks.client.achievements.model.panel.CodecAchievementCC;
  import _codec.projects.tanks.client.achievements.model.panel.VectorCodecAchievementCCLevel1;
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.codec.OptionalCodecDecorator;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.registry.ModelRegistry;
  import projects.tanks.client.achievements.model.Achievement;
  import projects.tanks.client.achievements.model.panel.AchievementCC;

  public class Activator implements IBundleActivator {
    public static var osgi:OSGi;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var local4:ICodec = null;
      osgi = param1;
      var local2:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local2.register(Long.getLong(1524513374,287342893),Long.getLong(623988280,-1549577978));
      local2.register(Long.getLong(1524513374,287342893),Long.getLong(392903733,700779252));
      var local3:IProtocol = IProtocol(osgi.getService(IProtocol));
      local4 = new CodecAchievement();
      local3.registerCodec(new EnumCodecInfo(Achievement,false),local4);
      local3.registerCodec(new EnumCodecInfo(Achievement,true),new OptionalCodecDecorator(local4));
      local4 = new CodecAchievementCC();
      local3.registerCodec(new TypeCodecInfo(AchievementCC,false),local4);
      local3.registerCodec(new TypeCodecInfo(AchievementCC,true),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecAchievementLevel1(false);
      local3.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(Achievement,false),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(Achievement,false),true,1),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecAchievementLevel1(true);
      local3.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(Achievement,true),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(Achievement,true),true,1),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecAchievementCCLevel1(false);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(AchievementCC,false),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(AchievementCC,false),true,1),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecAchievementCCLevel1(true);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(AchievementCC,true),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(AchievementCC,true),true,1),new OptionalCodecDecorator(local4));
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
