/*
 * @Author: TJUZQC
 * @Date: 2021-05-25 15:02:33
 * @LastEditors: TJUZQC
 * @LastEditTime: 2021-05-25 15:31:06
 * @Description: None
 */
package wordsconverter

import "strings"

const (
	UPPER_CASE = iota
	LOWER_CASE
	LOWER_CAMEL_CASE
	UPPER_CAMEL_CASE
	UNDER_SCORE_CASE
)

func Convert(origin string, mode int) (result string) {
	origin = strings.TrimSpace(origin)
	switch mode {
	case UPPER_CASE:
		result = convert2UpperCase(origin)
	case LOWER_CASE:
		result = convert2LowerCase(origin)
	case LOWER_CAMEL_CASE:
		result = convert2LowerCamelCase(origin)
	case UPPER_CAMEL_CASE:
		result = convert2UpperCamelCase(origin)
	case UNDER_SCORE_CASE:
		result = convert2UnderScoreCase(origin)
	}
	result = strings.ReplaceAll(result, " ", "")
	return
}

func convert2UpperCase(origin string) string {
	return strings.ToUpper(origin)
}

func convert2LowerCase(origin string) string {
	return strings.ToLower(origin)
}

func convert2LowerCamelCase(origin string) string {
	result := strings.Title(origin)
	result = strings.ToLower(result[0:1]) + result[1:]
	return result
}

func convert2UpperCamelCase(origin string) string {
	return strings.Title(origin)
}

func convert2UnderScoreCase(origin string) string {
	return strings.ReplaceAll(origin, " ", "_")
}
