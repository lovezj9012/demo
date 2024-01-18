export default class RouterInfo{
  //页面类型
  url:string
  //页面标题
  title:string

  constructor(url: string, title: string) {
    this.url=url
    this.title=title
  }
}