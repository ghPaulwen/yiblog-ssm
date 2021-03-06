package me.paul.yiblog_ssm.controller.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import me.paul.yiblog_ssm.entity.User;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

@Component
public class UserInterceptor extends HandlerInterceptorAdapter{
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		String str = request.getRequestURI();
		String contextPath = request.getContextPath();
		str = str.replace(contextPath, "");
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("currentUser");
		if(user == null ){
			response.sendRedirect(request.getContextPath() + "/login?target=" + str);
			return false;
		}
		if(user.getPower() == null || user.getPower().getId() < 1 || user.getPower().getId() > 2){
			request.setAttribute("message", "you are not a valid user");
			request.getRequestDispatcher("/message").forward(request, response);
			return false;
		}
		return true;
	}

}
