package alternativa.tanks.gui {
  import alternativa.tanks.gui.upgrade.UpgradeColors;
  import alternativa.tanks.model.item.upgradable.UpgradableItemParams;
  import alternativa.tanks.model.item.upgradable.UpgradableItemPropertyValue;
  import assets.Diamond;
  import controls.base.LabelBase;
  import flash.display.Sprite;
  import flash.text.TextFormatAlign;
  import forms.ranks.SmallRankIcon;
  import utils.FontParamsUtil;

  public class ModInfoRow extends Sprite {
    private static const RANK_WIDTH:int = 13;

    public const h:int = 17;
    public const hSpace:int = 10;

    public var labels:Vector.<LabelBase>;
    public var costLabel:LabelBase;
    public var crystalIcon:Diamond;
    public var rankIcon:SmallRankIcon;
    public var upgradeIndicator:UpgradeIndicator;
    public var costWidth:int;

    private var numberProperties:int = 0;
    private var _width:int;

    public function ModInfoRow(param1:int, param2:int) {
      var local4:LabelBase = null;
      super();
      this._width = param2;
      this.labels = new Vector.<LabelBase>(8);
      var local3:int = 0;
      while(local3 < 8) {
        local4 = new LabelBase();
        local4.color = 16777215;
        local4.align = TextFormatAlign.CENTER;
        local4.text = "ABC123";
        addChild(local4);
        this.labels[local3] = local4;
        local4.y = this.h - local4.height >> 1;
        local3++;
      }
      this.costLabel = new LabelBase();
      this.costLabel.color = 16777215;
      this.costLabel.align = TextFormatAlign.RIGHT;
      this.costLabel.text = "ABC123";
      addChild(this.costLabel);
      this.costLabel.y = this.h - this.costLabel.height >> 1;
      this.crystalIcon = new Diamond();
      addChild(this.crystalIcon);
      this.crystalIcon.y = this.h - this.crystalIcon.height >> 1;
      this.rankIcon = new SmallRankIcon();
      addChild(this.rankIcon);
      this.rankIcon.y = (this.h - this.rankIcon.height >> 1) + 1;
      this.upgradeIndicator = new UpgradeIndicator(param1);
      addChild(this.upgradeIndicator);
      this.upgradeIndicator.y = (this.h - this.upgradeIndicator.height >> 1) + 1;
    }

    public function select() : void {
      var local2:LabelBase = null;
      var local1:int = 0;
      while(local1 < 8) {
        local2 = this.labels[local1] as LabelBase;
        local2.color = 16777215;
        local2.sharpness = -100;
        local2.thickness = 100;
        local1++;
      }
      this.costLabel.sharpness = -100;
      this.costLabel.thickness = 100;
    }

    public function unselect() : void {
      var local2:LabelBase = null;
      var local1:int = 0;
      while(local1 < 8) {
        local2 = this.labels[local1] as LabelBase;
        local2.color = 16777215;
        local2.sharpness = FontParamsUtil.SHARPNESS_LABEL_BASE;
        local2.thickness = FontParamsUtil.THICKNESS_LABEL_BASE;
        local1++;
      }
      this.costLabel.color = 16777215;
      this.costLabel.sharpness = FontParamsUtil.SHARPNESS_LABEL_BASE;
      this.costLabel.thickness = FontParamsUtil.THICKNESS_LABEL_BASE;
    }

    public function setLabelsNum(param1:int) : void {
      this.numberProperties = param1;
      var local2:int = 0;
      while(local2 < this.labels.length) {
        this.labels[local2].visible = local2 < param1;
        local2++;
      }
    }

    public function setLabelsText(param1:UpgradableItemParams, param2:Vector.<UpgradableItemPropertyValue>) : void {
      var local4:UpgradableItemPropertyValue = null;
      var local5:LabelBase = null;
      var local3:int = 0;
      while(local3 < param2.length) {
        local4 = param2[local3];
        local5 = this.labels[local3];
        local5.text = local4.getValue(param1.getLevel());
        local5.color = UpgradeColors.getColor(param1,local4);
        local3++;
      }
    }

    public function updatePositions() : void {
      var local4:LabelBase = null;
      this.crystalIcon.x = this._width - this.crystalIcon.width - this.hSpace;
      this.costLabel.x = this.crystalIcon.x - 3 - this.costLabel.width;
      var local1:Number = this.crystalIcon.x - 3 - this.costWidth;
      this.rankIcon.x = local1 - this.hSpace - RANK_WIDTH;
      this.upgradeIndicator.x = this.rankIcon.x - this.upgradeIndicator.width - this.hSpace;
      var local2:Number = (this.upgradeIndicator.x - 2 * this.hSpace) / this.numberProperties;
      var local3:int = 0;
      while(local3 < this.numberProperties) {
        local4 = this.labels[local3];
        local4.x = Math.round(this.hSpace + local2 * local3 + (local2 - local4.width) / 2);
        local3++;
      }
    }

    public function getPositions() : Vector.<Number> {
      var local3:LabelBase = null;
      var local1:Vector.<Number> = new Vector.<Number>(this.numberProperties,true);
      var local2:int = 0;
      while(local2 < this.numberProperties) {
        local3 = this.labels[local2];
        local1[local2] = local3.x + local3.width * 0.5;
        local2++;
      }
      return local1;
    }
  }
}
