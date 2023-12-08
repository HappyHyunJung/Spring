class NoticeService {
	
	static getList(callback, error) {
		$.getJSON("/notices/pages",
		function(data) {
			if(callback) {
				console.log(data);
				callback(data);
			}
		}).fail(function(xhr, status, err) {
			if(error) {
				error(xhr.status + ' ' + status);
			}
		});
	}
	
	static displayTime(timeValue) {
		let today = new Date();
		let gap = today.getTime() - timeValue;
		let dateObj = new Date(timeValue);
		let str = "";
		if (gap < (1000 * 60 * 60 * 24)) {
			let hour = dateObj.getHours();
			let minute = dateObj.getMinutes();
			let second = dateObj.getSeconds();
			return [ (hour > 9 ? '' : '0') + hour, ':', (minute > 9 ? '' : '0') + minute, ':', (second > 9 ? '' : '0') + second].join('');
		} else {
			let year = dateObj.getFullYear();
			let month = dateObj.getMonth() + 1;
			let date = dateObj.getDate();
			return [year , '/', (month > 9 ? '' : '0') + month, '/', (date > 9 ? '' : '0') + date].join('');
		}
	}
	
	static get(rno, callback, error) {
		$.get("/notices/" + rno,
		function(result) {
			if(callback) {
				callback(result);
			}
		}).fail(function(xhr, status, err) {
			if(error) {
				error();
			}
		});
	}
}