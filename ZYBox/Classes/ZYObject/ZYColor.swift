import UIKit

extension UIColor {

    
    /// ** RGB 常规模式 **
    /// - Parameters:
    ///   - RGB: 红色 数值 0 ~ 255
    ///   - A:   透明 数值 0 ~ 100
    public convenience init(R: Int, G: Int, B: Int, A: CGFloat = 1.0) {
        self.init(red: CGFloat(R) / 255.0, green: CGFloat(G) / 255.0, blue: CGFloat(B) / 255.0, alpha: A)
    }

    /// ** RGB 特征模式 **
    /// - Parameters:
    ///   - LRGB: 明亮 模式 RGB 数值 0 ~ 255
    ///   - LA:   明亮 模式 ALPHA 数值 0 ~ 1
    ///   - DRGB: 暗黑 模式 RGB 数值 0 ~ 255
    ///   - DA:   暗黑 模式 ALPHA 数值 0 ~ 1
    public convenience init(LRGB: (R: Int, G: Int, B: Int), LA: CGFloat = 1.0, DRGB: (R: Int, G: Int, B: Int), DA: CGFloat = 1.0) {
        if #available(iOS 13.0, *) {
            self.init { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return UIColor(R: DRGB.R, G: DRGB.G, B: DRGB.B, A: DA);
                default:
                    return UIColor(R: LRGB.R, G: LRGB.G, B: LRGB.B, A: LA);
                }
            }
        } else {
            self.init(R: LRGB.R, G: LRGB.G, B: LRGB.B, A: LA);
        }
    }

    /// ** HEX 常规模式 **
    /// - Parameters:
    ///   - H: HEX 数值 000000 ~ FFFFFF
    ///   - A: 透明 数值 0 ~ 100
    public convenience init(H: String, A: CGFloat = 1.0) {
        var C = 0 as UInt64
        let _ = Scanner(string: H).scanHexInt64(&C)
        let M = 0x000000FF
        let R = Int(C >> 16) & M
        let G = Int(C >> 08) & M
        let B = Int(C >> 00) & M
        self.init(R: R, G: G, B: B, A: A);
    }

    /// ** HEX 特征模式 **
    /// - Parameters:
    ///   - LH: 明亮 模式 HEX 数值 000000 ~ FFFFFF
    ///   - LA: 明亮 模式 透明 数值 0 ~ 100
    ///   - DH: 暗黑 模式 HEX 数值 000000 ~ FFFFFF
    ///   - DA: 暗黑 模式 透明 数值 0 ~ 100
    public convenience init(LH: String, LA: CGFloat = 1.0, DH: String, DA: CGFloat = 1.0) {
        if #available(iOS 13.0, *) {
            self.init { traitCollection in
                switch traitCollection.userInterfaceStyle {
                case .dark:
                    return UIColor(H: DH, A: DA)
                default:
                    return UIColor(H: LH, A: LA)
                }
            }
        } else {
            self.init(H: LH, A: LA)
        }
    }
}

extension UIColor {
    
    /// 获取图片中指定坐标色值
    /// - Parameter image: 图片
    /// - Parameter point: 坐标
    public convenience init?(from image: UIImage, at point: CGPoint) {
        if point.x < 0 { return nil }
        if point.y < 0 { return nil }
        if point.x > image.size.width { return nil }
        if point.y > image.size.height { return nil }
        
        guard let cgImage = image.cgImage else { return nil }
        guard let dataProvider = cgImage.dataProvider else { return nil }
        guard let data = dataProvider.data else { return nil }
        guard let byte = CFDataGetBytePtr(data) else { return nil }

        let i = Int(((image.size.width * point.y) + point.x) * 4)

        var rgba: [Int] = []
        switch cgImage.bitmapInfo.rawValue {
        case 1:
            rgba = [0,1,2,3]
        default:
            rgba = [2,1,0,3]
        }
        
        let r = CGFloat(byte[i + rgba[0]]) / CGFloat(255.0)
        let g = CGFloat(byte[i + rgba[1]]) / CGFloat(255.0)
        let b = CGFloat(byte[i + rgba[2]]) / CGFloat(255.0)
        let a = CGFloat(byte[i + rgba[3]]) / CGFloat(255.0)
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
}
