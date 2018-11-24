<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Lobby</title>
<jsp:include page="../resources/header.jsp" />
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"
	rel="stylesheet">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/listLobbies.css"
	type="text/css">
</head>

<body>
	<jsp:include page="navbar.jsp" />
	<div class="page-title">
		<h1 align="center">LOBBIES</h1>
	</div>

	<%-- <c:if test="${not empty errorLobby}">
		<div class="alert alert-danger alert-dismissible" role="alert">
			<button type="button" class="close" data-dismiss="alert"
				aria-label="Close">
				<span aria-hidden="true">&times;</span>
			</button>
			<strong>${errorLobby}</strong>
		</div>
	</c:if> --%>
	<div class="container" style="background-color: lightgrey">
		<div class="row">
			<div class="col-lg-12">
				<div class="main-box clearfix">
					<div class="table-responsive">
						<table class="table user-list">
							<thead>
								<tr>
									<th><span>User</span></th>
									<th><span>Lobby</span></th>
									<th class="text-center"><span>Status Lobby</span></th>

									<th>&nbsp;</th>
								</tr>
							</thead>
							<!-- Si vanno a prendere tutte le lobby -->
							<c:forEach items="${lobbies}" var="lobby">
								<tbody>
									<tr>
										<td><img
											src="https://bootdey.com/img/Content/avatar/avatar1.png"
											alt=""> <!-- Si vanno a prendere tutti i giocatori di quella lobby  -->

											<span>Admin: ${lobby.creator.username}</span>
											 <c:forEach
												items="${lobby.players}" var="player">

												<%-- <c:if test="${player.isCreator()}">

												</c:if> --%>
												<br>
												 <c:if test="${player.username ne lobby.creator.username}">
													<span>Guest: ${player.username}</span>
												</c:if> 
											</c:forEach> <br></td>
										<%-- <td>${player.}</td> --%>
										<td>${lobby.name}</td>
										<c:choose>
											<c:when test="${lobby.players.size() lt 2}">
												<td class="text-center"><span
													class="label label-success">Players:
														${lobby.players.size()}/2</span></td>
											</c:when>
											<c:otherwise>
												<td class="text-center"><span
													class="label label-danger">Players:
														${lobby.players.size()}/2</span></td>
											</c:otherwise>
										</c:choose>

										<!--Pulsante join lobby  -->
										<td style="width: 20%;"><%-- <c:if
												test="${lobby.alreadyInLobby(user) eq false}">
 --%>

												<a
													href="${pageContext.request.contextPath}/joinLobby?lobby=${lobby.name}"
													class="table-link">
													<button style="font-size: 10px">
														Join Lobby <span class="fa-stack"> <i
															class="fa fa-square fa-stack-2x"></i> <i
															class="fa fa-arrow-circle-up fa-stack-1x fa-inverse"></i>
														</span>
													</button>
												</a>

											<%-- </c:if> --%> <!--Pulsante leave lobby  --> <%-- <c:if
												test="${lobby.alreadyInLobby(user) eq true}"> --%>
												<!-- se sei il creatore elimina -->
												<%-- <a
													href="${pageContext.request.contextPath}/leaveLobby?lobby=${lobby.name}"
													class="table-link danger"><button
														style="font-size: 10px">
														Leave Lobby <span class="fa-stack"> <i
															class="fa fa-square fa-stack-2x"></i> <i
															class="fa fa-trash-o fa-stack-1x fa-inverse"></i>
														</span>
													</button> </a>
											</c:if> <!-- Start game --> <c:if
												test="${lobby.players.size() gt 1  and lobby.creatorLobby(user) eq true }">
												<a href="${pageContext.request.contextPath}/startGame"
													class="table-link success">
													<button style="font-size: 10px">
														Start Game<span class="fa-stack"> <i
															class="fa fa-square fa-stack-2x" style="color: green"></i>
															<i class="fa fa-gamepad fa-stack-1x fa-inverse"></i>
														</span>
													</button>
												</a> --%>
											<%-- </c:if> --%></td>
									</tr>
								</tbody>
							</c:forEach>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%-- <div class="col-sm-4">
			<div class="container">
				<div class="row">
					<div class="col-md-4 col-sm-6">
						<div class="pricingTable6 green">
							<h3 class="title">${lobby.name}</h3>
							<c:choose>
								<c:when test="${lobby.size lt 2}">
									<div class="price-value">
										Players: ${lobby.size} <span class="month"></span>
									</div>
								</c:when>
								<c:otherwise>
									<div class="price-value-red">
										Players: ${lobby.size} <span class="month"></span>
									</div>
								</c:otherwise>
							</c:choose>
							<ul class="pricing-content">
							</ul>
							<a
								href="
								${pageContext.request.contextPath}/joinLobby?lobby=${lobby.name
								}
								"
								class="pricingTable-signup">Join Lobby</a>
						</div>
					</div>
				</div>
			</div>
			<br>
		</div>
 --%>



	<%-- <div class="col-sm-4">

			<div class="card-body">
				<ul class="list-unstyled mb-5 position-relative">
					<li>Players: ${lobby.size}</li>
					<!-- Da chiedere -->
					<li><a
						href="${pageContext.request.contextPath}/joinLobby?lobby=${lobby.name}">Join
							Lobby</a></li>
				</ul>
				<form class="form" role="form"
					action="joinLobby?lobby=${lobby.name}">
					<button type="submit" class="btn btn-default">Join Lobby</button>
				</form>
			</div>
		</div> --%>



	<!-- 	<div class="login-container">
		<h1>Create new Lobby</h1>
		<form method="POST" action="createLobby">
			<table>
				<tr>
					<td>Name</td>
					<td><input name="name" /></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td><input type="submit" value="Create" /></td>
				</tr>
			</table>
		</form>
	</div> -->

	<a href="${pageContext.request.contextPath}/refreshLobby">REFRESH</a>
</body>
</html>