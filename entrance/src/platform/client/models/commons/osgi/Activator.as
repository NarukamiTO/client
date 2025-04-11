package platform.client.models.commons.osgi {
  import _codec.platform.client.models.commons.description.CodecDescriptionModelCC;
  import _codec.platform.client.models.commons.description.VectorCodecDescriptionModelCCLevel1;
  import _codec.platform.client.models.commons.periodtime.CodecTimePeriodModelCC;
  import _codec.platform.client.models.commons.periodtime.VectorCodecTimePeriodModelCCLevel1;
  import _codec.platform.client.models.commons.types.CodecTimestamp;
  import _codec.platform.client.models.commons.types.CodecValidationStatus;
  import _codec.platform.client.models.commons.types.VectorCodecTimestampLevel1;
  import _codec.platform.client.models.commons.types.VectorCodecValidationStatusLevel1;
  import alternativa.osgi.OSGi;
  import alternativa.osgi.bundle.IBundleActivator;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.codec.OptionalCodecDecorator;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import platform.client.models.commons.description.DescriptionModelCC;
  import platform.client.models.commons.periodtime.TimePeriodModelCC;
  import platform.client.models.commons.types.Timestamp;
  import platform.client.models.commons.types.ValidationStatus;

  public class Activator implements IBundleActivator {
    public static var osgi:OSGi;

    public function Activator() {
      super();
    }

    public function start(param1:OSGi) : void {
      var local3:ICodec = null;
      osgi = param1;
      var local2:IProtocol = IProtocol(osgi.getService(IProtocol));
      local3 = new CodecDescriptionModelCC();
      local2.registerCodec(new TypeCodecInfo(DescriptionModelCC,false),local3);
      local2.registerCodec(new TypeCodecInfo(DescriptionModelCC,true),new OptionalCodecDecorator(local3));
      local3 = new CodecTimePeriodModelCC();
      local2.registerCodec(new TypeCodecInfo(TimePeriodModelCC,false),local3);
      local2.registerCodec(new TypeCodecInfo(TimePeriodModelCC,true),new OptionalCodecDecorator(local3));
      local3 = new CodecTimestamp();
      local2.registerCodec(new TypeCodecInfo(Timestamp,false),local3);
      local2.registerCodec(new TypeCodecInfo(Timestamp,true),new OptionalCodecDecorator(local3));
      local3 = new CodecValidationStatus();
      local2.registerCodec(new EnumCodecInfo(ValidationStatus,false),local3);
      local2.registerCodec(new EnumCodecInfo(ValidationStatus,true),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecDescriptionModelCCLevel1(false);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(DescriptionModelCC,false),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(DescriptionModelCC,false),true,1),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecDescriptionModelCCLevel1(true);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(DescriptionModelCC,true),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(DescriptionModelCC,true),true,1),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecTimePeriodModelCCLevel1(false);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(TimePeriodModelCC,false),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(TimePeriodModelCC,false),true,1),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecTimePeriodModelCCLevel1(true);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(TimePeriodModelCC,true),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(TimePeriodModelCC,true),true,1),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecTimestampLevel1(false);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Timestamp,false),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Timestamp,false),true,1),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecTimestampLevel1(true);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Timestamp,true),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new TypeCodecInfo(Timestamp,true),true,1),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecValidationStatusLevel1(false);
      local2.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(ValidationStatus,false),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(ValidationStatus,false),true,1),new OptionalCodecDecorator(local3));
      local3 = new VectorCodecValidationStatusLevel1(true);
      local2.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(ValidationStatus,true),false,1),local3);
      local2.registerCodec(new CollectionCodecInfo(new EnumCodecInfo(ValidationStatus,true),true,1),new OptionalCodecDecorator(local3));
    }

    public function stop(param1:OSGi) : void {
    }
  }
}
