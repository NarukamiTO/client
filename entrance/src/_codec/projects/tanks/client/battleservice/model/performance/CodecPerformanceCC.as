package _codec.projects.tanks.client.battleservice.model.performance {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import projects.tanks.client.battleservice.model.performance.PerformanceCC;

  public class CodecPerformanceCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_alertFPSRatioThreshold:ICodec;
    private var codec_alertFPSThreshold:ICodec;
    private var codec_alertMinTestTime:ICodec;
    private var codec_alertPingRatioThreshold:ICodec;
    private var codec_alertPingThreshold:ICodec;
    private var codec_indicatorHighFPS:ICodec;
    private var codec_indicatorHighFPSColor:ICodec;
    private var codec_indicatorHighPing:ICodec;
    private var codec_indicatorHighPingColor:ICodec;
    private var codec_indicatorLowFPS:ICodec;
    private var codec_indicatorLowFPSColor:ICodec;
    private var codec_indicatorLowPing:ICodec;
    private var codec_indicatorLowPingColor:ICodec;
    private var codec_indicatorVeryHighPing:ICodec;
    private var codec_indicatorVeryHighPingColor:ICodec;
    private var codec_indicatorVeryLowFPS:ICodec;
    private var codec_indicatorVeryLowFPSColor:ICodec;
    private var codec_qualityFPSThreshold:ICodec;
    private var codec_qualityIdleTime:ICodec;
    private var codec_qualityMaxAttempts:ICodec;
    private var codec_qualityRatioThreshold:ICodec;
    private var codec_qualityTestTime:ICodec;
    private var codec_qualityVisualizationSpeed:ICodec;

    public function CodecPerformanceCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_alertFPSRatioThreshold = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_alertFPSThreshold = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_alertMinTestTime = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_alertPingRatioThreshold = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_alertPingThreshold = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_indicatorHighFPS = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_indicatorHighFPSColor = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_indicatorHighPing = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_indicatorHighPingColor = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_indicatorLowFPS = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_indicatorLowFPSColor = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_indicatorLowPing = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_indicatorLowPingColor = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_indicatorVeryHighPing = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_indicatorVeryHighPingColor = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_indicatorVeryLowFPS = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_indicatorVeryLowFPSColor = param1.getCodec(new TypeCodecInfo(String,true));
      this.codec_qualityFPSThreshold = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_qualityIdleTime = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_qualityMaxAttempts = param1.getCodec(new TypeCodecInfo(int,false));
      this.codec_qualityRatioThreshold = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_qualityTestTime = param1.getCodec(new TypeCodecInfo(Float,false));
      this.codec_qualityVisualizationSpeed = param1.getCodec(new TypeCodecInfo(Float,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:PerformanceCC = new PerformanceCC();
      local2.alertFPSRatioThreshold = this.codec_alertFPSRatioThreshold.decode(param1) as Number;
      local2.alertFPSThreshold = this.codec_alertFPSThreshold.decode(param1) as Number;
      local2.alertMinTestTime = this.codec_alertMinTestTime.decode(param1) as Number;
      local2.alertPingRatioThreshold = this.codec_alertPingRatioThreshold.decode(param1) as Number;
      local2.alertPingThreshold = this.codec_alertPingThreshold.decode(param1) as Number;
      local2.indicatorHighFPS = this.codec_indicatorHighFPS.decode(param1) as int;
      local2.indicatorHighFPSColor = this.codec_indicatorHighFPSColor.decode(param1) as String;
      local2.indicatorHighPing = this.codec_indicatorHighPing.decode(param1) as int;
      local2.indicatorHighPingColor = this.codec_indicatorHighPingColor.decode(param1) as String;
      local2.indicatorLowFPS = this.codec_indicatorLowFPS.decode(param1) as int;
      local2.indicatorLowFPSColor = this.codec_indicatorLowFPSColor.decode(param1) as String;
      local2.indicatorLowPing = this.codec_indicatorLowPing.decode(param1) as int;
      local2.indicatorLowPingColor = this.codec_indicatorLowPingColor.decode(param1) as String;
      local2.indicatorVeryHighPing = this.codec_indicatorVeryHighPing.decode(param1) as int;
      local2.indicatorVeryHighPingColor = this.codec_indicatorVeryHighPingColor.decode(param1) as String;
      local2.indicatorVeryLowFPS = this.codec_indicatorVeryLowFPS.decode(param1) as int;
      local2.indicatorVeryLowFPSColor = this.codec_indicatorVeryLowFPSColor.decode(param1) as String;
      local2.qualityFPSThreshold = this.codec_qualityFPSThreshold.decode(param1) as Number;
      local2.qualityIdleTime = this.codec_qualityIdleTime.decode(param1) as Number;
      local2.qualityMaxAttempts = this.codec_qualityMaxAttempts.decode(param1) as int;
      local2.qualityRatioThreshold = this.codec_qualityRatioThreshold.decode(param1) as Number;
      local2.qualityTestTime = this.codec_qualityTestTime.decode(param1) as Number;
      local2.qualityVisualizationSpeed = this.codec_qualityVisualizationSpeed.decode(param1) as Number;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:PerformanceCC = PerformanceCC(param2);
      this.codec_alertFPSRatioThreshold.encode(param1,local3.alertFPSRatioThreshold);
      this.codec_alertFPSThreshold.encode(param1,local3.alertFPSThreshold);
      this.codec_alertMinTestTime.encode(param1,local3.alertMinTestTime);
      this.codec_alertPingRatioThreshold.encode(param1,local3.alertPingRatioThreshold);
      this.codec_alertPingThreshold.encode(param1,local3.alertPingThreshold);
      this.codec_indicatorHighFPS.encode(param1,local3.indicatorHighFPS);
      this.codec_indicatorHighFPSColor.encode(param1,local3.indicatorHighFPSColor);
      this.codec_indicatorHighPing.encode(param1,local3.indicatorHighPing);
      this.codec_indicatorHighPingColor.encode(param1,local3.indicatorHighPingColor);
      this.codec_indicatorLowFPS.encode(param1,local3.indicatorLowFPS);
      this.codec_indicatorLowFPSColor.encode(param1,local3.indicatorLowFPSColor);
      this.codec_indicatorLowPing.encode(param1,local3.indicatorLowPing);
      this.codec_indicatorLowPingColor.encode(param1,local3.indicatorLowPingColor);
      this.codec_indicatorVeryHighPing.encode(param1,local3.indicatorVeryHighPing);
      this.codec_indicatorVeryHighPingColor.encode(param1,local3.indicatorVeryHighPingColor);
      this.codec_indicatorVeryLowFPS.encode(param1,local3.indicatorVeryLowFPS);
      this.codec_indicatorVeryLowFPSColor.encode(param1,local3.indicatorVeryLowFPSColor);
      this.codec_qualityFPSThreshold.encode(param1,local3.qualityFPSThreshold);
      this.codec_qualityIdleTime.encode(param1,local3.qualityIdleTime);
      this.codec_qualityMaxAttempts.encode(param1,local3.qualityMaxAttempts);
      this.codec_qualityRatioThreshold.encode(param1,local3.qualityRatioThreshold);
      this.codec_qualityTestTime.encode(param1,local3.qualityTestTime);
      this.codec_qualityVisualizationSpeed.encode(param1,local3.qualityVisualizationSpeed);
    }
  }
}
