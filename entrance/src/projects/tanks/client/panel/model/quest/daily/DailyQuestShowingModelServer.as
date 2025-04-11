package projects.tanks.client.panel.model.quest.daily {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.OptionalMap;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import flash.utils.ByteArray;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.network.command.SpaceCommand;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.ISpace;

  public class DailyQuestShowingModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _givePrizeId:Long = Long.getLong(1508188063,-951132811);
    private var _givePrize_questClassIdCodec:ICodec;
    private var _openWindowId:Long = Long.getLong(490759748,732918938);
    private var _skipQuestForCrystalsId:Long = Long.getLong(745172834,-1601596721);
    private var _skipQuestForCrystals_questClassIdCodec:ICodec;
    private var _skipQuestForCrystals_skipPriceCodec:ICodec;
    private var _skipQuestForFreeId:Long = Long.getLong(1819574530,685112894);
    private var _skipQuestForFree_questClassIdCodec:ICodec;
    private var _skipQuestForShowedAdsId:Long = Long.getLong(1625524504,-1691983326);
    private var _skipQuestForShowedAds_questClassIdCodec:ICodec;
    private var model:IModel;

    public function DailyQuestShowingModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._givePrize_questClassIdCodec = this.protocol.getCodec(new TypeCodecInfo(Long,false));
      this._skipQuestForCrystals_questClassIdCodec = this.protocol.getCodec(new TypeCodecInfo(Long,false));
      this._skipQuestForCrystals_skipPriceCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._skipQuestForFree_questClassIdCodec = this.protocol.getCodec(new TypeCodecInfo(Long,false));
      this._skipQuestForShowedAds_questClassIdCodec = this.protocol.getCodec(new TypeCodecInfo(Long,false));
    }

    public function givePrize(param1:Long) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._givePrize_questClassIdCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._givePrizeId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function openWindow() : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local1:SpaceCommand = new SpaceCommand(Model.object.id,this._openWindowId,this.protocolBuffer);
      var local2:IGameObject = Model.object;
      var local3:ISpace = local2.space;
      local3.commandSender.sendCommand(local1);
      this.protocolBuffer.optionalMap.clear();
    }

    public function skipQuestForCrystals(param1:Long, param2:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._skipQuestForCrystals_questClassIdCodec.encode(this.protocolBuffer,param1);
      this._skipQuestForCrystals_skipPriceCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._skipQuestForCrystalsId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }

    public function skipQuestForFree(param1:Long) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._skipQuestForFree_questClassIdCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._skipQuestForFreeId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function skipQuestForShowedAds(param1:Long) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._skipQuestForShowedAds_questClassIdCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._skipQuestForShowedAdsId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
