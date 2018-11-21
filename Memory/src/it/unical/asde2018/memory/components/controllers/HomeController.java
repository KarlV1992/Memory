package it.unical.asde2018.memory.components.controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import it.unical.asde2018.memory.components.services.LobbyService;
import it.unical.asde2018.memory.components.services.LoginService;
import it.unical.asde2018.memory.model.User;

@Controller
public class HomeController {

	@Autowired
	private LoginService loginService;
	@Autowired
	private LobbyService lobbyService;

	private String username;

	@GetMapping("/")
	private String goToIndex(Model model, HttpSession session) {
		return "index";
	}

	@GetMapping("/registration")
	private String registration(Model model, HttpSession session, @RequestParam String username,
			@RequestParam String password) {
		if (!loginService.login(username, password)) {
			loginService.setCredentials(username, password);
			model.addAttribute("username", username);
			session.setAttribute("username", username);
			User user = new User(username, false);
			session.setAttribute("user", user);
			model.addAttribute("lobbies", lobbyService.getLobbies());
			return "lobby";
		} else
			model.addAttribute("errorRegistration", "Wrong credentials registration!");
		return "index";
	}

	@GetMapping("/login")
	private String login(Model model, HttpSession session, @RequestParam String username,
			@RequestParam String password) {
		if (loginService.login(username, password)) {
			model.addAttribute("username", username);
			session.setAttribute("username", username);
			User user = new User(username, false);
			session.setAttribute("user", user);
			model.addAttribute("lobbies", lobbyService.getLobbies());
			return "lobby";
		} else
			model.addAttribute("errorLogin", "Wrong credentials login!");
		return "index";
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session, Model model) {
		// System.out.println("logout");
		session.invalidate();
		return "index";
	}

	@RequestMapping("/rules")
	public String rules(HttpSession session, Model model) {
		return "rules";
	}

	@RequestMapping("/matchHistory")
	public String matchHistory(HttpSession session, Model model) {
		return "matchHistory";
	}

	@RequestMapping("/createLobby")
	public String createLobby(@RequestParam String name, HttpSession session, Model model) {
		username = (String) session.getAttribute("username");
		User user = new User(username, true);
		session.setAttribute("user", user);
		lobbyService.createLobby(name, user);
		// System.out.println(user);
		model.addAttribute("lobbies", lobbyService.getLobbies());
		return "lobby";
	}

	@RequestMapping({ "/joinLobby" })
	public String joinLobby(HttpServletRequest request, HttpSession session, Model model,
			@RequestParam(value = "lobby", defaultValue = "") String name) {
		if (lobbyService.notFullLoby(name)) {
			username = (String) session.getAttribute("username");
			// user = new User(username, true);
			User user = (User) session.getAttribute("user");
			lobbyService.joinLobby(name, user);
			model.addAttribute("lobbies", lobbyService.getLobbies());
			// session
			return "lobby";
		} else {
			model.addAttribute("errorLobby", name + " is full");
			model.addAttribute("lobbies", lobbyService.getLobbies());
		}
		return "lobby";
	}

	@RequestMapping({ "/leaveLobby" })
	public String leaveLobby(HttpServletRequest request, HttpSession session, Model model,
			@RequestParam(value = "lobby", defaultValue = "") String name) {
		username = (String) session.getAttribute("username");
		User user = (User) session.getAttribute("user");
		lobbyService.joinLobby(name, user);
		lobbyService.leaveLobby(name, user);
		model.addAttribute("lobbies", lobbyService.getLobbies());

		return "lobby";
	}

	@RequestMapping({ "/startGame" })
	public String joinLobby(HttpServletRequest request, HttpSession session, Model model) {
		return "game";
	}
}
