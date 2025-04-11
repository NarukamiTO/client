package alternativa.proplib {
  import alternativa.proplib.objects.PropMesh;
  import alternativa.proplib.objects.PropObject;
  import alternativa.proplib.objects.PropSprite;
  import alternativa.proplib.types.PropData;
  import alternativa.proplib.types.PropGroup;
  import alternativa.proplib.types.PropState;
  import alternativa.proplib.utils.ByteArrayMap;
  import alternativa.proplib.utils.TextureByteDataMap;
  import alternativa.utils.XMLUtils;
  import alternativa.utils.textureutils.TextureByteData;
  import flash.utils.ByteArray;

  public class PropLibrary {
    public static const LIB_FILE_NAME:String = "library.xml";
    public static const IMG_FILE_NAME:String = "images.xml";

    private var _rootGroup:PropGroup;
    private var files:ByteArrayMap;
    private var imageMap:TextureByteDataMap;

    public function PropLibrary(files:ByteArrayMap) {
      super();
      if(files == null) {
        throw new ArgumentError("Parameter files is null");
      }
      this.files = files;
      var imageMapData:ByteArray = files.getValue(IMG_FILE_NAME);
      if(imageMapData != null) {
        this.imageMap = this.parseImageMap(XML(imageMapData.toString()));
      }
      this._rootGroup = this.parseGroup(XML(files.getValue(LIB_FILE_NAME).toString()));
    }

    public function get name() : String {
      return this._rootGroup == null ? null : this._rootGroup.name;
    }

    public function get rootGroup() : PropGroup {
      return this._rootGroup;
    }

    private function parseImageMap(imagesXml:XML) : TextureByteDataMap {
      var image:XML = null;
      var originalTextureFileName:String = null;
      var diffuseName:String = null;
      var opacityName:String = null;
      var imageFiles:TextureByteDataMap = new TextureByteDataMap();
      for each(image in imagesXml.image) {
        originalTextureFileName = image.@name;
        diffuseName = image.attribute("new-name").toString().toLowerCase();
        opacityName = XMLUtils.getAttributeAsString(image,"alpha",null);
        if(opacityName != null) {
          opacityName = opacityName.toLowerCase();
        }
        imageFiles.putValue(originalTextureFileName,new TextureByteData(this.files.getValue(diffuseName),this.files.getValue(opacityName)));
      }
      return imageFiles;
    }

    private function parseGroup(groupXML:XML) : PropGroup {
      var propElement:XML = null;
      var groupElement:XML = null;
      var group:PropGroup = new PropGroup(XMLUtils.copyXMLString(groupXML.@name));
      for each(propElement in groupXML.prop) {
        group.addProp(this.parseProp(propElement));
      }
      for each(groupElement in groupXML.elements("prop-group")) {
        group.addGroup(this.parseGroup(groupElement));
      }
      return group;
    }

    private function parseProp(propXml:XML) : PropData {
      var stateXml:XML = null;
      var prop:PropData = new PropData(XMLUtils.copyXMLString(propXml.@name));
      var states:XMLList = propXml.state;
      if(states.length() > 0) {
        for each(stateXml in states) {
          prop.addState(XMLUtils.copyXMLString(stateXml.@name),this.parseState(stateXml));
        }
      } else {
        prop.addState(PropState.DEFAULT_NAME,this.parseState(propXml));
      }
      return prop;
    }

    private function parseState(stateXml:XML) : PropState {
      var lodXml:XML = null;
      var state:PropState = new PropState();
      var lods:XMLList = stateXml.lod;
      if(lods.length() > 0) {
        for each(lodXml in lods) {
          state.addLOD(this.parsePropObject(lodXml),Number(lodXml.@distance));
        }
      } else {
        state.addLOD(this.parsePropObject(stateXml),0);
      }
      return state;
    }

    private function parsePropObject(parentXmlElement:XML) : PropObject {
      if(parentXmlElement.mesh.length() > 0) {
        return this.parsePropMesh(parentXmlElement.mesh[0]);
      }
      if(parentXmlElement.sprite.length() > 0) {
        return this.parsePropSprite(parentXmlElement.sprite[0]);
      }
      throw new Error("Unknown prop type");
    }

    private function parsePropMesh(propXml:XML) : PropMesh {
      var textureXml:XML = null;
      var modelData:ByteArray = this.files.getValue(propXml.@file.toString().toLowerCase());
      var textureFiles:Object = null;
      if(propXml.texture.length() > 0) {
        textureFiles = {};
        for each(textureXml in propXml.texture) {
          textureFiles[XMLUtils.copyXMLString(textureXml.@name)] = textureXml.attribute("diffuse-map").toString().toLowerCase();
        }
      }
      var objectName:String = XMLUtils.getAttributeAsString(propXml,"object",null);
      return new PropMesh(modelData,objectName,textureFiles,this.files,this.imageMap);
    }

    private function parsePropSprite(propXml:XML) : PropSprite {
      var textureFile:String = propXml.@file.toString().toLowerCase();
      var textureData:TextureByteData = this.imageMap == null ? new TextureByteData(this.files.getValue(textureFile)) : this.imageMap.getValue(textureFile);
      var originX:Number = XMLUtils.getAttributeAsNumber(propXml,"origin-x",0.5);
      var originY:Number = XMLUtils.getAttributeAsNumber(propXml,"origin-y",0.5);
      var scale:Number = XMLUtils.getAttributeAsNumber(propXml,"scale",1);
      return new PropSprite(textureData,originX,originY,scale);
    }
  }
}
