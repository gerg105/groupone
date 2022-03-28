function onSuccess(googleUser) {
	var token = googleUser.getAuthResponse().id_token;
	$.ajax({
		url: "http://localhost:8080/GroupOne/googleLoginCheck?token=" + token,
		method: "post",
		success: function(data) {
			if (data.stat == "OK") {
				window.location.href = "http://localhost:8080/GroupOne/";
			} else {
				var auth2 = gapi.auth2.getAuthInstance();
				auth2.signOut();
				Swal.fire({
					icon: 'error',
					title: 'Oops...',
					text: '查無此帳號，請先註冊喔!',
				}).then((result) => {
					if (result.isConfirmed) {
						window.location.href = "http://localhost:8080/GroupOne/register";
					} 
				})
			}
		}
	})
}

function onLoad() {
	gapi.load('auth2', function() {
		gapi.auth2.init();
	});
}

function signOut() {
	var auth2 = gapi.auth2.getAuthInstance();
	auth2.signOut().then(function() {
		$.ajax({
			url: "http://localhost:8080/GroupOne/logout",
			method: "get",
			success: function() {
				window.location.href = "/GroupOne/";
			}
		})
	});

}