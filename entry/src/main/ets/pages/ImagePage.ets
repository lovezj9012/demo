@Entry
@Component
struct ImagePage {
  @State imageWidth: number = 100

  build() {
      Column({space:30}) {
        Row() {
          Image($r('app.media.icon'))
            .width(this.imageWidth)
            .interpolation(ImageInterpolation.High)
        }
        .width('100%')
        .height(350)
        .justifyContent(FlexAlign.Center)

        Row() {
          Text($r('app.string.width_label'))
            .lineHeight(20)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          TextInput({ placeholder: '请输入图片宽度', text: this.imageWidth.toFixed(0) })
            .type(InputType.Number)
            .width(150)
            .onChange(value => {
              this.imageWidth = parseInt(value);
            })
        }
        .width('100%')
        .padding({left:50,right:50})
        .justifyContent(FlexAlign.SpaceBetween)


        Row() {
          Button($r('app.string.button_text'), { type: ButtonType.Capsule })
            .onClick(event => {
              if (this.imageWidth < 300)
                this.imageWidth += 5;
            })
          Button($r('app.string.button_in'), { type: ButtonType.Capsule })
            .onClick(() => {
              if (this.imageWidth >100)
                this.imageWidth -= 5;
            })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceEvenly)

        Row() {
          Slider({
            min: 5,
            max: 300,
            value: this.imageWidth,
            step: 5,
            style: SliderStyle.OutSet,
            direction: Axis.Horizontal,
            reverse: false
          })
            .width('90%')
            .showTips(true)
            .trackThickness(10)
            .onChange((value: number, model: SliderChangeMode) => {
              this.imageWidth = value;
            })
        }



      }
      .width('100%')
      //.justifyContent(FlexAlign.Center)
      //.alignItems(HorizontalAlign.Center)
    .height('100%')
  }
}