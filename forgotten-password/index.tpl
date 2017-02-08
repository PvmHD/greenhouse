<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Forgotten password</title>

<?smarty if $smarty.const.BOOTSTRAP_LOGIN === true ?>

  <link href="<?smarty $smarty.const.EXTERNAL_URL ?>/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
  
 <link rel="stylesheet" href="<?smarty $smarty.const.EXTERNAL_URL ?>/bootstrap/font-awesome-4.7.0/css/font-awesome.min.css">
		

  <style>



body, html{
     height: 100%;
 	background-repeat: no-repeat;
 	background-color: #d3d3d3;
 	font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif, sans-serif;
}

.main{
 	margin-top: 70px;
}



hr{
	width: 100%;
	color: #fff;
}

.form-group{
	margin-bottom: 15px;
}

label{
	margin-bottom: 15px;
}

input,
input::-webkit-input-placeholder {
    font-size: 11px;
    padding-top: 3px;
}

.main-login{
 	background-color: #fff;
    /* shadows and rounded borders */
    -moz-border-radius: 2px;
    -webkit-border-radius: 2px;
    border-radius: 2px;
    -moz-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
    -webkit-box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
    box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);

}

.main-center{
 	margin-top: 30px;
 	margin: 0 auto;
 	max-width: 380px;
    padding: 40px 40px;

}

.login-button{
	margin-top: 5px;
}

.login-register{
	font-size: 12px;
	text-align: center;
}

    
    
  </style>

  <?smarty else ?>
  
  <link rel="stylesheet" type="text/css" href="<?smarty $smarty.const.FULLCAL_URL ?>/style/style.css" />

<link rel="stylesheet" type="text/css" href="<?smarty $smarty.const.FULLCAL_URL ?>/register/css/view.css" media="all">


  <style>

   
  </style>
  
  <?smarty /if ?>

</head>

<body>

    <?smarty if $smarty.const.BOOTSTRAP_LOGIN === true ?>

      <div class="container">
          <?smarty if $success ?>
                    <?smarty if isset($msg) && !empty($msg) ?>
                           <span style="color:green;position:relative;"><?smarty $msg ?></span>
                   <?smarty /if ?>
           <?smarty else ?>
			<div class="row main">
				
	           
                               
				<div class="main-login main-center">
                                   
				<div class="panel-title text-center">
                                        <?smarty $smarty.const.CALENDAR_TITLE ?><h3><span id="login_label" style="font-style:italic;">Forgot password</span></h3>
                                        <hr />
                                     </div>	
                                    <form class="form-horizontal" method="post" action="<?smarty $smarty.const.FULLCAL_URL ?>/forgotten-password/?action=reset">
						
						

						<div class="form-group">
							<label for="username" class="cols-sm-2 control-label" id="login_username_label">Email</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="email" id="username"  placeholder="Enter your email"  value="<?smarty $form.firstname|default:'' ?>" />
                                                                        
                                                                        
								</div>
							</div>
						</div>
						

						<div class="form-group ">
							<input type="submit" class="btn btn-primary btn-lg btn-block login-button submit"  id="login" value="Reset my password" title="Login" />
                                                </div>
                                                       
                                                  
					</form>
				</div>
			</div>
           <?smarty /if ?>
		</div>
      
<?smarty else ?>

<!-- body start -->
	<div id="wrap">

		<!-- body pannel start -->
		<div id="bodyPannel">
			<?smarty if $success ?>
				 <?smarty if isset($msg) && !empty($msg) ?>
					<span style="color:green;position:relative;"><?smarty $msg ?></span>
				<?smarty /if ?>
			<?smarty else ?>

				<form id="form_837763"  method="post" action="?action=reset">
					<div class="form_description">
						<h3>Reset your password</h3>

						 <?smarty if isset($msg) && !empty($msg) ?>
							<span style="color:red;position:relative;"><?smarty $msg ?></span>
						<?smarty /if ?>

					</div>
					<ul >
						<li id="li_4" >
							<span>
								<input type="text" name= "email" class="element text" maxlength="255" size="25" value="<?smarty $form.firstname|default:"" ?>"/>
								<label>Email</label>
							</span>
						</li>

						<li class="buttons">
						    <input type="hidden" name="form_id" value="837345" />
							<input id="saveForm" class="button_text" type="submit" name="submit" value="Submit" />
						</li>

					</ul>
				</form>
			<?smarty /if ?>
		</div>
		<!-- body pannel end -->
		<br class="spacer" />

	</div>
	<!-- body end -->

<?smarty /if ?>

	

</body>
</html>
