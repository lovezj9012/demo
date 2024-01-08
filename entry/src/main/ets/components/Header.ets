import router from '@ohos.router'
@Component
export struct Header {
  private title: ResourceStr
  @State param:any = router.getParams()

  build() {
    Row() {
      Image($r('app.media.ic_public_back'))
        .width(30)
        .onClick(()=>{
          router.showAlertBeforeBackPage({
            message:'确认返回吗？'
          })
          router.back()
        })
      if(this.param.id&&this.title) {
        Text(this.param.id + '' + this.title)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
      }
      Blank() //用户占空位
      Image($r('app.media.ic_public_refresh'))
        .width(30)
    }
    .width('100%')
    .height(30)

  }
}