package projects.tanks.client.partners.osgi {
  import _codec.projects.tanks.client.partners.impl.asiasoft.CodecAsiasoftLoginCC;
  import _codec.projects.tanks.client.partners.impl.asiasoft.VectorCodecAsiasoftLoginCCLevel1;
  import _codec.projects.tanks.client.partners.impl.odnoklassniki.CodecOdnoklassnikiUrlParams;
  import _codec.projects.tanks.client.partners.impl.odnoklassniki.VectorCodecOdnoklassnikiUrlParamsLevel1;
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
  import projects.tanks.client.partners.impl.asiasoft.AsiasoftLoginCC;
  import projects.tanks.client.partners.impl.odnoklassniki.OdnoklassnikiUrlParams;

  public class Activator implements IBundleActivator {
    public static var osgi:OSGi;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var local4:ICodec = null;
      osgi = param1;
      var local2:ModelRegistry = ModelRegistry(OSGi.getInstance().getService(ModelRegistry));
      local2.register(Long.getLong(207007060,1485489233),Long.getLong(341705782,434846708));
      local2.register(Long.getLong(207007060,1485489233),Long.getLong(1221568909,812989734));
      local2.register(Long.getLong(1386392731,192355220),Long.getLong(890493454,-1969693338));
      local2.register(Long.getLong(1386392731,192355220),Long.getLong(710462738,-568001163));
      local2.register(Long.getLong(1051840655,1324649819),Long.getLong(344321414,-2112933510));
      local2.register(Long.getLong(698539894,1283037116),Long.getLong(10593173,209532726));
      local2.register(Long.getLong(1215969521,1635618100),Long.getLong(885983582,663395758));
      local2.register(Long.getLong(588118997,-1972708299),Long.getLong(418477357,1914357093));
      local2.register(Long.getLong(922991279,696481140),Long.getLong(1973287099,901106954));
      local2.register(Long.getLong(1273864280,-1855777834),Long.getLong(801007651,-1207089136));
      local2.register(Long.getLong(723546009,-53480122),Long.getLong(47453348,912731532));
      local2.register(Long.getLong(982237961,270527442),Long.getLong(780155353,1879122584));
      var local3:IProtocol = IProtocol(osgi.getService(IProtocol));
      local4 = new CodecAsiasoftLoginCC();
      local3.registerCodec(new TypeCodecInfo(AsiasoftLoginCC,false),local4);
      local3.registerCodec(new TypeCodecInfo(AsiasoftLoginCC,true),new OptionalCodecDecorator(local4));
      local4 = new CodecOdnoklassnikiUrlParams();
      local3.registerCodec(new EnumCodecInfo(OdnoklassnikiUrlParams,false),local4);
      local3.registerCodec(new EnumCodecInfo(OdnoklassnikiUrlParams,true),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecAsiasoftLoginCCLevel1(false);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(AsiasoftLoginCC,false),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(AsiasoftLoginCC,false),true,1),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecAsiasoftLoginCCLevel1(true);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(AsiasoftLoginCC,true),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(AsiasoftLoginCC,true),true,1),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecOdnoklassnikiUrlParamsLevel1(false);
      local3.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(OdnoklassnikiUrlParams,false),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(OdnoklassnikiUrlParams,false),true,1),new OptionalCodecDecorator(local4));
      local4 = new VectorCodecOdnoklassnikiUrlParamsLevel1(true);
      local3.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(OdnoklassnikiUrlParams,true),false,1),local4);
      local3.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(OdnoklassnikiUrlParams,true),true,1),new OptionalCodecDecorator(local4));
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
