// Date 객체 생성
let date = new Date();

const renderCalendar = () => {
  const viewYear = date.getFullYear();
  const viewMonth = date.getMonth();

  // year-month 채우기
  document.querySelector(".year-month").textContent = `${viewYear}년 ${
    viewMonth + 1
  }월`;

  // 지난 달 마지막 Date, 이번 달 마지막 Date
  const prevLast = new Date(viewYear, viewMonth, 0);
  const thisLast = new Date(viewYear, viewMonth + 1, 0);

  const PLDate = prevLast.getDate();
  const PLDay = prevLast.getDay();

  const TLDate = thisLast.getDate();
  const TLDay = thisLast.getDay();

  // Dates 기본 배열들
  const prevDates = [];
  const thisDates = [...Array(TLDate + 1).keys()].slice(1);
  const nextDates = [];

  // prevDates 계산
  if (PLDay !== 6) {
    for (let i = 0; i < PLDay + 1; i++) {
      prevDates.unshift(PLDate - i);
    }
  }

  // nextDates 계산
  if (thisDates.length + prevDates.length <= 35) {
    for (let i = 1; i < 14 - TLDay; i++) {
      nextDates.push(i);
    }
  } else {
    for (let i = 1; i < 7 - TLDay; i++) {
      nextDates.push(i);
    }
  }

  // Dates 합치기
  const dates = prevDates.concat(thisDates, nextDates);

  // Dates 정리
  const firstDateIndex = dates.indexOf(1);
  const lastDateIndex = dates.lastIndexOf(TLDate);
  dates.forEach((date, i) => {
    const condition =
      i >= firstDateIndex && i < lastDateIndex + 1 ? "this" : "other";

    dates[
      i
    ] = `<button class="date"><span class="${condition}">${date}</span></button>`;
  });

  // Dates 그리기
  document.querySelector(".dates").innerHTML = dates.join("");

  // 오늘 날짜 그리기
  const today = new Date();
  if (viewMonth === today.getMonth() && viewYear === today.getFullYear()) {
    for (let date of document.querySelectorAll(".this")) {
      if (+date.innerText === today.getDate()) {
        date.classList.add("today");
        break;
      }
    }
  }
};

//이전 달 이돈
const prevMonth = () => {
  date.setDate(1);
  date.setMonth(date.getMonth() - 1);
  renderCalendar();
};

//다음 달 이동
const nextMonth = () => {
  date.setDate(1);
  date.setMonth(date.getMonth() + 1);
  renderCalendar();
};

//이번 달 이동
const goToday = () => {
  date = new Date();
  renderCalendar();
};

renderCalendar();

//daily 모달창 열기닫기
const openD = () => {
  document.querySelector(".daily-modal").classList.remove("hidden");
};

const closeD = () => {
  document.querySelector(".daily-modal").classList.add("hidden");
  document.getElementById("daily-modal-title").value = "";
  document.getElementById("daily-modal-start").value = "";
  document.getElementById("daily-modal-end").value = "";
  document.getElementById("daily-modal-place").value = "";
};

document.querySelector(".list-first").addEventListener("click", openD);
document.querySelector(".daily-edit-btn").addEventListener("click", openD);
document.querySelector(".daily-accept-btn").addEventListener("click", closeD);
document.querySelector(".daily-cancel-btn").addEventListener("click", closeD);

//plan 모달창 열기닫기
const openP = () => {
  document.querySelector(".plan-modal").classList.remove("hidden");
};

const closeP = () => {
  document.querySelector(".plan-modal").classList.add("hidden");
  document.getElementById("plan-modal-title").value = "";
};

document.querySelectorAll(".plan-title").forEach((title) => {
  title.addEventListener("click", openP);
});
document.querySelector(".plan-edit-btn").addEventListener("click", openP);
document.querySelector(".plan-accept-btn").addEventListener("click", closeP);
document.querySelector(".plan-cancel-btn").addEventListener("click", closeP);

//plan 체크박스 상호작용
const planCheckBox = document.querySelectorAll(".plan-checkbox");

planCheckBox.forEach((box) => {
  box.addEventListener("click", () => {
    if (box.dataset.value == 0) {
      box.setAttribute("style", "background-color:white");
      box.dataset.value = 1;
      box.nextElementSibling.setAttribute(
        "style",
        "text-decoration: line-through"
      );
    } else {
      box.setAttribute("style", "background-color:rgba(0,0,0,0)");
      box.dataset.value = 0;
      box.nextElementSibling.setAttribute("style", "text-decoration: none");
    }
  });
});
