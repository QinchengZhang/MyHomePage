package controllers

import (
	"crypto/md5"
	"encoding/hex"
)

func Sign(appId, query, salt, secret string) string {
	str := appId + query + salt + secret
	return md5encode(str)
}

func md5encode(str string) string {
	md5Ctx := md5.New()
	md5Ctx.Write([]byte(str))
	cipherStr := md5Ctx.Sum(nil)
	return hex.EncodeToString(cipherStr)
}
