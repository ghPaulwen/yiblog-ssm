<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>WJY的笔记本</title>

<!-- Bootstrap Core CSS -->
<link href="${pageContext.request.contextPath }/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom CSS -->
<link href="${pageContext.request.contextPath }/css/blog-home.css" rel="stylesheet">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body>
	<!-- Navigation -->
	<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
		<div class="container">
			<!-- Brand and toggle get grouped for better mobile display -->
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#bs-example-navbar-collapse-1">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="${pageContext.request.contextPath }/index">WJY的笔记本</a>
			</div>
			<!-- Collect the nav links, forms, and other content for toggling -->
			<div class="collapse navbar-collapse"
				id="bs-example-navbar-collapse-1">
				<ul class="nav navbar-nav">
					<li><a href="${pageContext.request.contextPath }/about">关于</a></li>
					<li><a href="${pageContext.request.contextPath }/feedback/save">反馈</a></li>
					<li><a href="${pageContext.request.contextPath }/link/save">申请友链</a></li>
				</ul>
			</div>
			<!-- /.navbar-collapse -->
		</div>
		<!-- /.container -->
	</nav>
	<!-- Page Content -->
	<div class="container">
		<div class="row">
			<!-- Blog Entries Column -->
			<div class="col-md-8">
				<h1 class="page-header">
					Notebook Of Mine <small>just for the future</small>
				</h1>
				<c:if test="${hide==null }">
				<ul class="pager">				
				<c:choose>
				  <c:when test="${category!=null }">
				    <li class="previous"><a href="${pageContext.request.contextPath }/passage/page/${category }/${lastPage}">上一页</a></li>
					<li class="next"><a href="${pageContext.request.contextPath }/passage/page/${category }/${nextPage}">下一页</a></li>
				  </c:when>
				  <c:otherwise>
				    <li class="previous"><a href="${pageContext.request.contextPath }/passage/page/${lastPage}">上一页</a></li>
					<li class="next"><a href="${pageContext.request.contextPath }/passage/page/${nextPage}">下一页</a></li>
				  </c:otherwise>
				</c:choose>
				</ul>
				</c:if>
				<c:forEach items="${listPassage }" var="passage">
					<!-- Blogs -->
					<h2>
						<a href="${pageContext.request.contextPath }/passage/get/${passage.id}">${passage.title }</a>
						<small>by <a href="${pageContext.request.contextPath }/about">${passage.author.name }</a></small>
					</h2>
					<p>
						<span class="glyphicon glyphicon-time"></span> 发布于 <fmt:formatDate value="${passage.writetime }" pattern="yyyy年MM月dd日"/> 
					</p>
					<hr>
					<div class="row">
					<div class="col-xs-4">
					<img class="img-responsive" src="${pageContext.request.contextPath }${passage.subCategory.logopath}"
						alt="">
					</div>
					<div class="col-xs-8">
					<p>${passage.outline }</p>
					<a class="btn btn-primary" href="${pageContext.request.contextPath }/passage/get/${passage.id}">阅读全文<span
						class="glyphicon glyphicon-chevron-right"></span></a>
					</div>
					</div>
					<hr>
				</c:forEach>
				<!-- Pager -->				
				<c:if test="${hide==null }">
				<ul class="pager">				
				<c:choose>
				  <c:when test="${category!=null }">
				    <li class="previous"><a href="${pageContext.request.contextPath }/passage/page/${category }/${lastPage}">上一页</a></li>
					<li class="next"><a href="${pageContext.request.contextPath }/passage/page/${category }/${nextPage}">下一页</a></li>
				  </c:when>
				  <c:otherwise>
				    <li class="previous"><a href="${pageContext.request.contextPath }/passage/page/${lastPage}">上一页</a></li>
					<li class="next"><a href="${pageContext.request.contextPath }/passage/page/${nextPage}">下一页</a></li>
				  </c:otherwise>
				</c:choose>
				</ul>
				</c:if>
			</div>
			<!-- Blog Sidebar Widgets Column -->
			<div class="col-md-4">
			    <div class="well">
				<!-- Blog Search Well -->
				<div class="well">
					<h4>搜索</h4>
					<form id="search_form" action="${pageContext.request.contextPath }/passage/search" method="get">
					<div class="input-group">
						<input name="content" type="text" class="form-control" >
						<span class="input-group-btn">
						<button id="btn_submit" class="btn btn-default" type="button">
							<span class="glyphicon glyphicon-search"></span>
						</button>
						</span>
					</div>
					</form>
					<!-- /.input-group -->
				</div>
				<!-- Blog Categories Well -->
				<div class="well">
					<h4>文章分类</h4>
					<div class="row">
						<div class="col-lg-6">
							<ul class="list-unstyled">
								<c:forEach items="${requestScope.listSubCategory }"
									var="subCategory" begin="0" end="${requestScope.halfOfCates}">
									<li><a href="${pageContext.request.contextPath }/passage/page/${subCategory.id}/1">${subCategory.name }</a>&nbsp;(${subCategory.passageCount })</li>
								</c:forEach>
							</ul>
						</div>
						<!-- /.col-lg-6 -->
						<div class="col-lg-6">
							<ul class="list-unstyled">
								<c:forEach items="${requestScope.listSubCategory }"
									var="subCategory" begin="${requestScope.halfOfCates + 1}">
									<li><a href="${pageContext.request.contextPath }/passage/page/${subCategory.id}/1">${subCategory.name }</a>&nbsp;(${subCategory.passageCount })</li>
								</c:forEach>
							</ul>
						</div>
						<!-- /.col-lg-6 -->
					</div>
					<!-- /.row -->
				</div>
				</div>
				
				<!-- Link Well -->
				<div class="well">
				  <h4>推荐网站</h4>
				  <h4></h4>
				  <c:forEach items="${listLink}" var="link">
				    <h4><a target="_blank" href="${link.url }"><c:out value="${link.name }"/></a></h4>
				  </c:forEach>
				</div>
				
				<!-- Side Widget Well -->
				<div class="well">
					<h4>${build.content } : <fmt:formatDate value="${build.time }" pattern="yyyy年MM月dd日"/></h4>
					<h4>${lastUpdate.content } : <fmt:formatDate value="${lastUpdate.time }" pattern="yyyy年MM月dd日"/></h4>
				</div>
			</div>
		</div>
		<!-- /.row -->
		<hr>
		<!-- Footer -->
		<footer>
			<div class="row">
				<div class="col-lg-12">
					<p>Copyright &copy; WJY的笔记本</p>
				</div>
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
		</footer>
	</div>
	<!-- /.container -->
	<!-- jQuery -->
	<script src="${pageContext.request.contextPath }/js/jquery.js"></script>
	<!-- Bootstrap Core JavaScript -->
	<script src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
	<script type="text/javascript">
	  $(document).ready(function(){
		  $("#btn_submit").click(function(){
			  $("#search_form").submit();
		  });
	  });
	</script>
	<script type="text/javascript">var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");document.write(unescape("%3Cspan id='cnzz_stat_icon_1260575777'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s4.cnzz.com/z_stat.php%3Fid%3D1260575777%26show%3Dpic1' type='text/javascript'%3E%3C/script%3E"));</script>
</body>

</html>