// 文件：ZYPhotos.swift
// 作者：Yzd
// 日期：2023/10/31
// 版权：Copyright © 2023 稚杨科技. All rights reserved.

import UIKit
import Photos

public class ZYPhotosThumbnail: NSObject {

    public var collection: PHCollection!
    public var assets: [PHAsset] = []
    public var localizedTitle: String? = nil
    public var count: Int = 0

    public convenience init(_ collection: PHCollection) {
        self.init()
        self.collection = collection
    }
    
}

public class ZYPhotos: NSObject {
    
    /// 获取照片库中指定目录中的内容
    /// - Parameters:
    ///   - collectionList: 查询目录，空值则查询根目录
    ///   - options: 筛选条件
    /// - Returns: 目录中的内容
    public class func collections(_ collectionList: PHCollectionList? = nil, _ options: PHFetchOptions? = nil) -> [PHCollection] {
        var collections: [PHCollection] = []
        if let collectionList = collectionList {
            let result = PHCollection.fetchCollections(in: collectionList, options: options)
            result.enumerateObjects { collection, index, stop in
                collections.append(collection)
            }
        } else {
            let result = PHCollection.fetchTopLevelUserCollections(with: options)
            result.enumerateObjects { collection, index, stop in
                collections.append(collection)
            }
        }
        return collections
    }
    
    /// 获取照片库中指定相册中的内容
    /// - Parameters:
    ///   - assetCollection: 指定的相册
    ///   - options: 筛选条件
    /// - Returns: 相册中的内容
    public class func assets(_ assetCollection: PHAssetCollection, _ options: PHFetchOptions? = nil) -> [PHAsset] {
        var assets: [PHAsset] = []
        let result = PHAsset.fetchAssets(in: assetCollection, options: options)
        result.enumerateObjects { asset, index, stop in
            assets.append(asset)
        }
        return assets
    }
    
    /// 获取照片库中指定类型相册中的内容
    /// - Parameters:
    ///   - type: 指定的系统相册一级类型
    ///   - subtype: 指定的系统相册二级类型
    ///   - options: 筛选条件
    /// - Returns: 相册中的内容
    public class func assets(_ type: PHAssetCollectionType, _ subtype: PHAssetCollectionSubtype, _ options: PHFetchOptions? = nil) -> [PHAsset] {
        var assets: [PHAsset] = []
        let result = PHAssetCollection.fetchAssetCollections(with: type, subtype: subtype, options: options)
        result.enumerateObjects { album, index, stop in
            let result = PHAsset.fetchAssets(in: album, options: options)
            result.enumerateObjects { asset, index, stop in
                assets.append(asset)
            }
        }
        return assets
    }
    
    /// 获取照片库中指定内容的封面
    /// - Parameters:
    ///   - collection: 指定的内容
    ///   - options: 查询条件
    /// - Returns: 内容的封面
    public class func thumbnail(_ collection: PHCollection, _ options: PHFetchOptions? = nil) -> ZYPhotosThumbnail {
        let thumbnail = ZYPhotosThumbnail(collection)
        if let collectionList = collection as? PHCollectionList {
            let result = PHCollection.fetchCollections(in: collectionList, options: options)
            result.enumerateObjects { collection, index, stop in
                if let collection = collection as? PHAssetCollection {
                    let result = PHAsset.fetchAssets(in: collection, options: options)
                    if let result = result.firstObject {
                        thumbnail.assets.append(result)
                    }
                }
            }
            thumbnail.localizedTitle = collectionList.localizedTitle
            thumbnail.count = result.count
        } else if let assetCollection = collection as? PHAssetCollection {
            let result = PHAsset.fetchAssets(in: assetCollection, options: options)
            if let result = result.firstObject {
                thumbnail.assets.append(result)
            }
            thumbnail.localizedTitle = assetCollection.localizedTitle
            thumbnail.count = result.count
        }
        return thumbnail
    }
    
    /// 获取照片库中系统相册的封面
    /// - Parameters:
    ///   - type: 指定的系统相册一级类型
    ///   - subtype: 指定的系统相册二级类型
    ///   - options: 筛选条件
    /// - Returns: 相册的封面
    public class func thumbnail(_ type: PHAssetCollectionType, _ subtype: PHAssetCollectionSubtype, _ options: PHFetchOptions? = nil) -> ZYPhotosThumbnail? {
        let result = PHAssetCollection.fetchAssetCollections(with: type, subtype: subtype, options: options)
        if let result = result.firstObject {
            return ZYPhotos.thumbnail(result, options)
        } else {
            return nil
        }
    }
}

