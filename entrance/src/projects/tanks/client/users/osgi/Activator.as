package projects.tanks.client.users.osgi {
  import _codec.projects.tanks.client.users.model.friends.CodecFriendsCC;
  import _codec.projects.tanks.client.users.model.friends.VectorCodecFriendsCCLevel1;
  import _codec.projects.tanks.client.users.model.friends.container.CodecUserContainerCC;
  import _codec.projects.tanks.client.users.model.friends.container.VectorCodecUserContainerCCLevel1;
  import _codec.projects.tanks.client.users.model.switchbattleinvite.CodecNotificationEnabledCC;
  import _codec.projects.tanks.client.users.model.switchbattleinvite.VectorCodecNotificationEnabledCCLevel1;
  import _codec.projects.tanks.client.users.model.userbattlestatistics.rank.CodecRankBounds;
  import _codec.projects.tanks.client.users.model.userbattlestatistics.rank.VectorCodecRankBoundsLevel1;
  import _codec.projects.tanks.client.users.services.chatmoderator.CodecChatModeratorLevel;
  import _codec.projects.tanks.client.users.services.chatmoderator.VectorCodecChatModeratorLevelLevel1;
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
  import projects.tanks.client.users.model.friends.FriendsCC;
  import projects.tanks.client.users.model.friends.container.UserContainerCC;
  import projects.tanks.client.users.model.switchbattleinvite.NotificationEnabledCC;
  import projects.tanks.client.users.model.userbattlestatistics.rank.RankBounds;
  import projects.tanks.client.users.services.chatmoderator.ChatModeratorLevel;

  public class Activator implements IBundleActivator {
    public static var osgi:OSGi;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var local4:ICodec = null;
      osgi = param1;
      var local2:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local2.register(Long.getLong(1693173045,628784534),Long.getLong(608205693,1898592764));
      local2.register(Long.getLong(1693173045,628784534),Long.getLong(370363039,338480872));
      local2.register(Long.getLong(1693173045,628784534),Long.getLong(311681954,1684738000));
      local2.register(Long.getLong(1693173045,628784534),Long.getLong(348947857,-1693710961));
      local2.register(Long.getLong(1693173045,628784534),Long.getLong(444676649,1880663147));
      local2.register(Long.getLong(1693173045,628784534),Long.getLong(910302409,-1168735433));
      local2.register(Long.getLong(1693173045,628784534),Long.getLong(766260615,-36774901));
      local2.register(Long.getLong(1696580544,685225790),Long.getLong(1466630272,-1977249165));
      local2.register(Long.getLong(1696580544,685225790),Long.getLong(1779101803,-1074606030));
      local2.register(Long.getLong(100897389,708983546),Long.getLong(203629091,-1595335121));
      local2.register(Long.getLong(100897389,708983546),Long.getLong(2017534548,29039506));
      local2.register(Long.getLong(1552139010,1361964288),Long.getLong(1433634624,1589914165));
      local2.register(Long.getLong(1552139010,1361964288),Long.getLong(1493000398,-12480436));
      local2.register(Long.getLong(1435596993,-649634714),Long.getLong(1727765184,1572488911));
      local2.register(Long.getLong(1435596993,-649634714),Long.getLong(2021113166,-552663310));
      var local3:IProtocol = IProtocol(osgi.getService(IProtocol));
      local4 = new CodecFriendsCC();
      local3.registerCodec(new TypeCodecInfo(FriendsCC,false),local4);
      local3.registerCodec(new TypeCodecInfo(FriendsCC,true),new OptionalCodecDecorator(local4));
      local4 = new CodecUserContainerCC();
      local3.registerCodec(new TypeCodecInfo(UserContainerCC,false),local4);
      local3.registerCodec(new TypeCodecInfo(UserContainerCC,true),new OptionalCodecDecorator(local4));
      local4 = new CodecNotificationEnabledCC();
      local3.registerCodec(new TypeCodecInfo(NotificationEnabledCC,false),local4);
      local3.registerCodec(new TypeCodecInfo(NotificationEnabledCC,true),new OptionalCodecDecorator(local4));
      local4 = new CodecRankBounds();
      local3.registerCodec(new TypeCodecInfo(RankBounds,false),local4);
      local3.registerCodec(new TypeCodecInfo(RankBounds,true),new OptionalCodecDecorator(local4));
      local4 = new CodecChatModeratorLevel();
      local3.registerCodec(new EnumCodecInfo(ChatModeratorLevel,false),local4);
      local3.registerCodec(new EnumCodecInfo(ChatModeratorLevel,true),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecFriendsCCLevel1(false);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(FriendsCC,false),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(FriendsCC,false),true,1),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecFriendsCCLevel1(true);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(FriendsCC,true),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(FriendsCC,true),true,1),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecUserContainerCCLevel1(false);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UserContainerCC,false),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UserContainerCC,false),true,1),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecUserContainerCCLevel1(true);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UserContainerCC,true),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(UserContainerCC,true),true,1),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecNotificationEnabledCCLevel1(false);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(NotificationEnabledCC,false),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(NotificationEnabledCC,false),true,1),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecNotificationEnabledCCLevel1(true);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(NotificationEnabledCC,true),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(NotificationEnabledCC,true),true,1),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecRankBoundsLevel1(false);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(RankBounds,false),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(RankBounds,false),true,1),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecRankBoundsLevel1(true);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(RankBounds,true),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(RankBounds,true),true,1),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecChatModeratorLevelLevel1(false);
      local3.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(ChatModeratorLevel,false),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(ChatModeratorLevel,false),true,1),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecChatModeratorLevelLevel1(true);
      local3.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(ChatModeratorLevel,true),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(ChatModeratorLevel,true),true,1),new OptionalCodecDecorator(local4));
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
