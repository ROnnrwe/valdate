#!/bin/bash

# 입력값 검사
if [ "$#" -ne 3 ]; then
  echo "입력값 오류"
  exit 1
fi

# 월, 일, 연도 입력받기
month=$1
day=$2
year=$3

# 월을 대문자로 변환하기
month=$(echo "$month" | awk '{print toupper(substr($0,1,1)) tolower(substr($0,2))}')

# 월 변환 테이블 설정
declare -A month_map
month_map=(
  ["jan"]="Jan" ["january"]="Jan" ["1"]="Jan"
  ["feb"]="Feb" ["february"]="Feb" ["2"]="Feb"
  ["mar"]="Mar" ["march"]="Mar" ["3"]="Mar"
  ["apr"]="Apr" ["april"]="Apr" ["4"]="Apr"
  ["may"]="May" ["5"]="May"
  ["jun"]="Jun" ["june"]="Jun" ["6"]="Jun"
  ["jul"]="Jul" ["july"]="Jul" ["7"]="Jul"
  ["aug"]="Aug" ["august"]="Aug" ["8"]="Aug"
  ["sep"]="Sep" ["september"]="Sep" ["9"]="Sep"
  ["oct"]="Oct" ["october"]="Oct" ["10"]="Oct"
  ["nov"]="Nov" ["november"]="Nov" ["11"]="Nov"
  ["dec"]="Dec" ["december"]="Dec" ["12"]="Dec"
)

# 월을 표준 형태로 변환
month=${month_map[$month]}

# 월이 올바르지 않은 경우
if [ -z "$month" ]; then
  echo "월 오류 + {$1}는 유효하지 않습니다"
  exit 1
fi

# 윤년 판별 함수
is_leap_year() {
  local year=$1
  if (( year % 4 == 0 )); then
    if (( year % 400 == 0 )); then
      return 0
    elif (( year % 100 == 0 )); then
      return 1
    else
      return 0
    fi
  else
    return 1
  fi
}

# 각 달의 일 수 설정
declare -A days_in_month
days_in_month=( ["Jan"]=31 ["Feb"]=28 ["Mar"]=31 ["Apr"]=30 ["May"]=31 ["Jun"]=30 ["Jul"]=31 ["Aug"]=31 ["Sep"]=30 ["Oct"]=31 ["Nov"]=30 ["Dec"]=31 )

# 윤년일 경우 2월의 일 수 설정
if is_leap_year "$year"; then
  days_in_month["Feb"]=29
fi

# 일(day) 유효성 검사
if (( day < 1 || day > ${days_in_month[$month]} )); then
  echo "$year년 $month월 $day일은 유효하지 않습니다"
  exit 1
fi

# 유효한 날짜 출력
echo "${month} ${day} ${year}"
