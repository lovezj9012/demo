
import PreferenceUtil from '../common/utils/PreferencesUtil'

@Component
export default struct IndexFontSizePanel{

  @Consume fontSize:number
  fontSizeLabel:object={
    14:'小',
    16:'标准',
    18:'大',
    20:'特大'
  }

  build(){
    Column(){
      Text(this.fontSizeLabel[this.fontSize]).fontSize(20)
      Row({space:5}){
        Text('A').fontSize(14).fontWeight(FontWeight.Bold)
        Slider({
          min:14,
          max:20,
          step:2,
          value:this.fontSize
        })
          .showSteps(true)
          .trackThickness(6)
          .layoutWeight(1)
          .onChange(val=>{
            this.fontSize=val
            //更新数据
            PreferenceUtil.putPreferenceValue('MyPreference',this.fontSizeLabel[val],val)
          })
        Text('A').fontSize(20).fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .width('100%')
    .padding(15)
    .backgroundColor('#fff1f0f0')
    .borderRadius(20)

  }
}