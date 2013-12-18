<?php

namespace NABC\IndividualBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use NABC\IndividualBundle\Entity\Individual;
use Symfony\Component\HttpFoundation\Response;

class IndividualController extends Controller
{
    public function registerAction()
    {

        $params = array();
        $content = $this->get("request")->getContent();
	var_dump($content);
        if(!empty($content))
        {
            $params = json_decode($content, true);
        }


	$query_param["email"] = $params["email"];

	$query_ind = $this->getDoctrine()->getRepository('NABCIndividualBundle:Individual')->findBy($query_param);
	
	if($query_ind){
		return new Response("Individual Registered", 201);
	}

        $individual = new Individual();
        $individual->setFirstName($params["firstName"]);
        $individual->setLastName($params["lastName"]);
        $individual->setEmail($params["email"]);
        $individual->setPhoneNumber($params["phoneNumber"]);
        $individual->setAddress($params["address"]);
        $individual->setSuiteApt($params["suiteApt"]);
        $individual->setZipCode($params["zipCode"]);
        $individual->setSsn($params["ssn"]);
        $individual->setDBA($params["dba"]);
        $individual->setDOB($params["dob"]);

	
        $em = $this->getDoctrine()->getManager();
        $em->persist($individual);
        $em->flush();
	
        return new Response("Individual ".$individual->getId()." Registered", 201);
    }
    
    public function infoAction($id)
    {
        
	//Get from database, Create JSON, put individual info to JSON
        $returnX = array();
        $individual = $this->getDoctrine()->getRepository('NABCIndividualBundle:Individual')->find($id);
        if(!$individual){
            return new Response('No individual with id = '.$id, 400);
        }
        $returnX["first_name"] = $individual->getFirstName();
        $returnX["last_name"] = $individual->getLastName();
        $returnX["email"] = $individual->getEmail();
        $returnX["phone_number"] = $individual->getPhoneNumber();
        $returnX["address"] = $individual->getAddress();
        $returnX["apt"] = $individual->getSuiteApt();
        $returnX["zip_code"] = $individual->getZipCode();
        $returnX["ssn"] = $individual->getSsn();
        $returnX["dba"] = $individual->getDBA();
        $returnX["birthday"] = $individual->getDOB();


        $sendOut = new Response();
        $sendOut->setContent(json_encode($returnX));
        $sendOut->headers->set('Content-Type', 'application/json');
        $sendOut->setStatusCode(201);
        return $sendOut;
    }

    public function deleteAction($id)
    {
    
        $em = $this->getDoctrine()->getManager();
        $individual = $em->getRepository('NABCIndividualBundle:Individual')->find($id);
        if(!$individual){
            return new Response('No individual with id = '.$id,400);
        }
        $em->remove($individual);
        $em->flush();
        return new Response($id,200);
    }

    public function batch_registerAction(){

        $params = array();
        $content = $this->get("request")->getContent();
	var_dump($content);       
 	if(!empty($content))
        {
            $params = json_decode($content, true);
        }
	
	var_dump($params);

	ob_start();
	var_dump($params);
	$result = ob_get_clean();


	$i = 0;
		
	while(($param = $params[$i++]) != NULL) {
		var_dump($param);
		$query_param["email"] = $param["email"];

	        $query_ind = $this->getDoctrine()->getRepository('NABCIndividualBundle:Individual')->findBy($query_param);

        	if($query_ind){
                	continue;
        	}

		$individual = new Individual();
       		$individual->setFirstName($param["firstName"]);
        	$individual->setLastName($param["lastName"]);
        	$individual->setEmail($param["email"]);
        	$individual->setPhoneNumber($param["phoneNumber"]);
       	 	$individual->setAddress($param["address"]);
        	$individual->setSuiteApt($param["suiteApt"]);
        	$individual->setZipCode($param["zipCode"]);
        	$individual->setSsn($param["ssn"]);
        	$individual->setDBA($param["dba"]);
        	$individual->setDOB($param["dob"]);
	

        	$em = $this->getDoctrine()->getManager();
        	$em->persist($individual);
        	$em->flush();
	}

	return new Response("Batch", 201);
    }    
}

?>

