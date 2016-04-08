package com.kaishengit.util;

import java.io.IOException;
import java.util.Properties;

/**
 * 读取config.properties文件的工具类
 * @author  lisi
 *
 */
public class ConfigProp {
    private static Properties prop = new Properties();
    static {
        try {
            prop.load(ConfigProp.class.getClassLoader().getResourceAsStream("config.properties"));
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("读取文件config.properties异常");
        }
    }

    /**
     *
     * @param key 键
     * @return 键对应的 值
     */
    public static String get(String key){
        return prop.getProperty(key);
    }
}
