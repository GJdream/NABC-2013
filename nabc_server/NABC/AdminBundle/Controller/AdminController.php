<?php

namespace NABC\AdminBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use NABC\AdminBundle\Entity\Individual;
use Symfony\Component\HttpFoundation\Response;

class AdminController extends Controller
{
    public function loginAction()
    {
        $logger = $this->get('logger');
	$logger->crit("Admin Main Action");
	$content = $this->get("request")->getContent();
	if(empty($content))
        {
	    return new Response('empty', 201); 
        }
	$adminid=$content["id"];
	$adminpwd = $content["pwd"];
	$admin = $this->getDoctrine()->getRepository('NABCAdminBundle:Admin')->find($adminid);

	if($adminpwd!=$admin->getPwd())
	{
		return new Response('Error',201);
	}

        return new Response('Login', 201);
    }

    public function mainAction()
    {
	$logger = $this->get('logger');
	$logger->crit("Admin Main Action");
	$individuals = $this->getDoctrine()->getRepository('NABCAdminBundle:Individual')->findAll();
	$businesses = $this->getDoctrine()->getRepository('NABCAdminBundle:Business')->findAll();

	$logger->crit($individuals[0]->getId());
	$logger->crit($businesses[0]->getId());

	$this->get('cache')->save('individuals', $individuals);
	$this->get('cache')->save('businesses', $businesses);

	return $this->render(
			'NABCAdminBundle:Main:main.html.twig',
			array('individuals' => $individuals, 
			'businesses' => $businesses,
			'individuals_q' => $individuals, 
			'businesses_q' => $businesses)
		);
    }

    public function infoIndividualAction()
    {
	$logger = $this->get('logger');
	$logger->crit("Admin Info Action");
	
	$request = $this->get("request");

	$params = $request->request->all();
	
	foreach ($params as $key => $val) {
		if($val == ""){
			unset($params[$key]);
		}
	}	 	
	
	$result = $this->getDoctrine()->getRepository('NABCAdminBundle:Individual')->findBy($params);
	$logger->crit($result[0]->getId());

	return $this->render(
			'NABCAdminBundle:Main:main.html.twig',
			array('individuals_q' => $result, 
			'businesses' => $this->get('cache')->fetch('businesses'), 
			'individuals' => $this->get('cache')->fetch('individuals'), 
			'businesses_q' => $this->get('cache')->fetch('businesses'))
		);
    }

    public function infoBusinessAction()
    {
	$logger = $this->get('logger');
	$logger->crit("Admin Info Action");

	$request = $this->get("request");

        $params = $request->request->all();

	foreach ($params as $key => $val) {
                if($val == ""){
                        unset($params[$key]);
                }
        }

	$result = $this->getDoctrine()->getRepository('NABCAdminBundle:Business')->findBy($params);
	$logger->crit($result[0]->getId());

	return $this->render(
                        'NABCAdminBundle:Main:main.html.twig',
                        array('individuals' => $this->get('cache')->fetch('individuals'), 
			'businesses_q' => $result, 
			'individuals_q' => $this->get('cache')->fetch('individuals'),
			'businesses' => $this->get('cache')->fetch('businesses'))
                );
    }
}
?>

