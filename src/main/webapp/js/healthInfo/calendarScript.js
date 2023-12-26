$(function () {
    // 초기 설정 및 변수
    var calendarWidth = 400;
    var currentYear = 2023;
    var currentMonth = 12;

    var months = [
        "JANUARY", "FEBRUARY", "MARCH", "APRIL", "MAY", "JUNE",
        "JULY", "AUGUST", "SEPTEMBER", "OCTOBER", "NOVEMBER", "DECEMBER"
    ];

    var weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

    // DOM 요소 선택
    var calendar = $("#calendar");
    var header = calendar.find("#calendar_header");
    var weekdaysContainer = calendar.find("#calendar_weekdays");
    var content = calendar.find("#calendar_content");

    // 달력 초기화 함수
    function initializeCalendar() {
        var currentDate = new Date();
        currentYear = currentDate.getFullYear();
        currentMonth = currentDate.getMonth() + 1;
    }

    // 달력 생성 및 업데이트 함수
    function updateCalendar() {
        generateWeekdaysHeader();
        var monthData = generateMonthData();
        renderCalendar(monthData);
        adjustCalendarSize();
        handleDateClick(); // 날짜 클릭 이벤트 처리 함수 호출
        updateMonthText(); // 월 텍스트 업데이트
    }

    // 요일 헤더 생성 함수
    function generateWeekdaysHeader() {
        weekdaysContainer.empty();
        for (var i = 0; i < 7; i++) {
            weekdaysContainer.append("<div>" + weekdays[i].substring(0, 3) + "</div>");
        }
    }

    // 월 데이터 생성 함수
    function generateMonthData() {
        var monthData = [];
        for (var day = 1; day <= getLastDayOfMonth(currentYear, currentMonth); day++) {
            var weekday = weekdays[getDayOfWeek(currentYear, currentMonth, day)];
            monthData.push({ day: day, weekday: weekday });
        }
        return monthData;
    }

    // 달력 렌더링 함수
    function renderCalendar(monthData) {
        content.empty();

        var startIndex = 0;
        var foundStartIndex = false;

        // 첫째 주 시작 인덱스 찾기
        while (!foundStartIndex) {
            if (weekdays[startIndex] == monthData[0].weekday) {
                foundStartIndex = true;
            } else {
                content.append('<div class="blank"></div>');
                startIndex++;
            }
        }

        // 달력 채우기
        for (var i = 0; i < 42 - startIndex; i++) {
            var dayData = i >= monthData.length ? null : monthData[i];
            var dayNumber = dayData ? dayData.day : null;

            var dayElement = dayData && isToday(new Date(currentYear, currentMonth - 1, dayNumber))
                ? '<div class="today">' : "<div>";

            content.append(dayElement + (dayNumber || "") + "</div>");
        }

        // 스타일 및 헤더 업데이트
        header.find("div.month-year").text(months[currentMonth - 1] + " " + currentYear);
    }

    // 날짜 클릭 이벤트 처리
    function handleDateClick() {
        content.on("click", "div", function () {
            // 이전에 선택된 날짜의 배경 초기화
            content.find('.selected-date, .today').removeClass('selected-date today');

            var selectedDay = $(this).text();
            if (selectedDay) {
                var selectedDate = new Date(currentYear, currentMonth - 1, selectedDay);

                // 선택된 날짜에 배경 추가
                $(this).addClass('selected-date');
                console.log(formatDate(selectedDate));

                // 여기에서 선택된 날짜에 대한 작업을 수행하세요.
                // 예: 다른 처리 또는 화면에 표시 등
            }
        });
    }

    // 달력 크기 조절 함수
    function adjustCalendarSize() {
        var calendarElement = $("#calendar").css("width", calendarWidth + "px");
        calendarElement.find("#calendar_weekdays, #calendar_content").css("width", calendarWidth + "px")
            .find("div").css({
                width: calendarWidth / 7 + "px",
                height: calendarWidth / 7 + "px",
                "line-height": calendarWidth / 7 + "px"
            });
        calendarElement.find("#calendar_header").css({ height: calendarWidth * (1 / 7) + "px" })
            .find('.arrow').css("line-height", calendarWidth * (1 / 7) + "px");
    }

    // 월 업데이트 함수
    function updateMonth(direction) {
        if (direction === "다음") {
            currentMonth++;
            if (currentMonth > 12) {
                currentMonth = 1;
                currentYear++;
            }
        } else if (direction === "이전") {
            currentMonth--;
            if (currentMonth < 1) {
                currentMonth = 12;
                currentYear--;
            }
        }

        updateCalendar();
    }

    // 월 텍스트 업데이트 함수
    function updateMonthText() {
        header.find(".month-year").text(months[currentMonth - 1] + " " + currentYear);
    }

    // 특정 월의 마지막 날짜를 반환하는 함수
    function getLastDayOfMonth(year, month) {
        return (new Date(year, month, 0)).getDate();
    }

    // 특정 날짜의 요일을 반환하는 함수
    function getDayOfWeek(year, month, day) {
        return (new Date(year, month - 1, day)).getDay();
    }

    // 주어진 날짜가 오늘인지 확인하는 함수
    function isToday(date) {
        var today = new Date();
        return date.getFullYear() === today.getFullYear() &&
            date.getMonth() === today.getMonth() &&
            date.getDate() === today.getDate();
    }

    // 날짜를 "년/월/일" 형식의 문자열로 변환하는 함수
    function formatDate(date) {


        return date.getFullYear() + "/" + (date.getMonth() + 1) + "/" + date.getDate();
    }

    // 초기화
    initializeCalendar();
    updateCalendar();

    // 이벤트 처리
    header.find('.left-arrow').on("click", function () {
        updateMonth("이전");
    });

    header.find('.right-arrow').on("click", function () {
        updateMonth("다음");
    });
});