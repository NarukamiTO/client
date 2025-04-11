package platform.client.core.general.socialnetwork.osgi {
  import _codec.map.String__String;
  import _codec.platform.client.core.general.socialnetwork.models.socialnetworkparameters.CodecSocialNetworkParametersCC;
  import _codec.platform.client.core.general.socialnetwork.models.socialnetworkparameters.VectorCodecSocialNetworkParametersCCLevel1;
  import _codec.platform.client.core.general.socialnetwork.types.CodecGender;
  import _codec.platform.client.core.general.socialnetwork.types.CodecLoginParameters;
  import _codec.platform.client.core.general.socialnetwork.types.VectorCodecGenderLevel1;
  import _codec.platform.client.core.general.socialnetwork.types.VectorCodecLoginParametersLevel1;
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.codec.OptionalCodecDecorator;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.MapCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.core.general.socialnetwork.models.socialnetworkparameters.SocialNetworkParametersCC;
  import platform.client.core.general.socialnetwork.types.Gender;
  import platform.client.core.general.socialnetwork.types.LoginParameters;

  public class Activator implements IBundleActivator {
    public static var osgi:OSGi;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var local3:ICodec = null;
      osgi = param1;
      var local2:IProtocol = IProtocol(osgi.getService(IProtocol));
      local3 = new CodecSocialNetworkParametersCC();
      local2.registerCodec(new TypeCodecInfo(SocialNetworkParametersCC,false),local3);
      local2.registerCodec(new TypeCodecInfo(SocialNetworkParametersCC,true),new OptionalCodecDecorator(local3));
      local3 = new CodecGender();
      local2.registerCodec(new EnumCodecInfo(Gender,false),local3);
      local2.registerCodec(new EnumCodecInfo(Gender,true),new OptionalCodecDecorator(local3));
      local3 = new CodecLoginParameters();
      local2.registerCodec(new TypeCodecInfo(LoginParameters,false),local3);
      local2.registerCodec(new TypeCodecInfo(LoginParameters,true),new OptionalCodecDecorator(local3));
      local3 = new String__String(false,false);
      local2.registerCodec(new MapCodecInfo(new TypeCodecInfo(String,false),new TypeCodecInfo(String,false),false),local3);
      local2.registerCodec(new MapCodecInfo(new TypeCodecInfo(String,false),new TypeCodecInfo(String,false),true),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecSocialNetworkParametersCCLevel1(false);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(SocialNetworkParametersCC,false),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(SocialNetworkParametersCC,false),true,1),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecSocialNetworkParametersCCLevel1(true);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(SocialNetworkParametersCC,true),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(SocialNetworkParametersCC,true),true,1),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecGenderLevel1(false);
      local2.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(Gender,false),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(Gender,false),true,1),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecGenderLevel1(true);
      local2.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(Gender,true),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(Gender,true),true,1),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecLoginParametersLevel1(false);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoginParameters,false),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoginParameters,false),true,1),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecLoginParametersLevel1(true);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoginParameters,true),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(LoginParameters,true),true,1),new OptionalCodecDecorator(local3));
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
