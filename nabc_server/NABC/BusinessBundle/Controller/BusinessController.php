<?php

namespace NABC\BusinessBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use NABC\BusinessBundle\Entity\Business;
use Symfony\Component\HttpFoundation\Response;

class BusinessController extends Controller
{
    public function registerAction()
    {

        $params = array();
        $content = $this->get("request")->getContent();
        if(!empty($content))
        {
            $params = json_decode($content, true);
        }

	$query_param["email"] = $params["email"];

        $query_bus = $this->getDoctrine()->getRepository('NABCBusinessBundle:Business')->findBy($query_param);

        if($query_bus){
                return new Response("Business Registered", 201);
        }

        $business = new Business();
	$business->setCorporationName($params["corporationName"]);
        $business->setFirstName($params["firstName"]);
        $business->setLastName($params["lastName"]);
        $business->setEmail($params["email"]);
        $business->setPhoneNumber($params["phoneNumber"]);
        $business->setAddress($params["address"]);
        $business->setSuiteApt($params["suiteApt"]);
        $business->setZipCode($params["zipCode"]);
        $business->setSsn($params["ssn"]);
        $business->setDba($params["dba"]);
	$business->setDob($params["dob"]);
	$business->setType($params["type"]);
        $business->setBusinessDescription($params["businessDescription"]);
        $business->setFedTaxID($params["fedTaxID"]);
        $business->setBusinessAddress($params["businessAddress"]);
        $business->setBusinessSuiteApt($params["businessSuiteApt"]);
        $business->setBusinessZipCode($params["businessZipCode"]);
        $business->setCcSales($params["ccSales"]);
        $business->setHighestSales($params["highestSales"]);
        $business->setYearInBusiness($params["yearsInBusiness"]);
        $em = $this->getDoctrine()->getManager();
        $em->persist($business);
        $em->flush();

        return new Response('Business '.$business->getId().' Register',201);
    }
    
    public function infoAction($id)
    {
	//Get from database, Create JSON, put business info to JSON
        $returnX = array();
        $business = $this->getDoctrine()->getRepository('NABCBusinessBundle:Business')->find($id);
        if(!$business){
            return new Response('No business with id = '.$id,400);
        }
        $returnX["first_name"] = $business->getFirstName();
        $returnX["last_name"] = $business->getLastName();
        $returnX["email"] = $business->getEmail();
        $returnX["phone_number"] = $business->getPhoneNumber();
        $returnX["address"] = $business->getAddress();
        $returnX["apt"] = $business->getSuiteApt();
        $returnX["zip_code"] = $business->getZipCode();
        $returnX["ssn"] = $business->getSsn();
        $returnX["dba"] = $business->getDba();
        $returnX["birthday"] = $business->getDob();
        $returnX["business_type"] = $business->getType();
        $returnX["business_des"] = $business->getBusinessDescription();
        $returnX["tax_id"] = $business->getFedTaxId();
        $returnX["business_address"] = $business->getBusinessAddress();
        $returnX["business_apt"] = $business->getBusinessSuiteApt();
        $returnX["business_zip_code"] = $business->getBusinessZipCode();
        $returnX["ccsales"] = $business->getCcSales();
        $returnX["highest_sales"] = $business->getHighestSales();
        $returnX["business_years"] = $business->getYearInBusiness();
        $returnX["aid"] = $business->getAid();
        $returnX["fid"] = $business->getFid();
        $returnX["msid"] = $business->getMsid();
        $returnX["corporation_name"] = $business->getCorporationName();

        $sendOut = new Response();
        $sendOut->setContent(json_encode($returnX));
        $sendOut->headers->set('Content-Type', 'application/json');
        $sendOut->setStatusCode(201);
        return $sendOut;
    }

    public function deleteAction($id)
    {

        $em = $this->getDoctrine()->getManager();
        $business = $em->getRepository('NABCBusinessBundle:Business')->find($id);
        if(!$business){
            return new Response('No business with id = '.$id,400);
        }
        $em->remove($business);
        $em->flush();
        return new Response($id,201);
    }

    public function batch_registerAction()
    {

        $params = array();
        $content = $this->get("request")->getContent();
        if(!empty($content))
        {
            $params = json_decode($content, true);
        }

	$i = 0;
	while(($param = $params[$i++])!=NULL) {
		$query_param["email"] = $param["email"];

        	$query_bus = $this->getDoctrine()->getRepository('NABCBusinessBundle:Business')->findBy($query_param);

        	if($query_bus){
                	continue;
      	 	}		
	
		$business = new Business();
       	 	$business->setCorporationName($param["corporationName"]);
        	$business->setFirstName($param["firstName"]);
        	$business->setLastName($param["lastName"]);
        	$business->setEmail($param["email"]);
        	$business->setPhoneNumber($param["phoneNumber"]);
        	$business->setAddress($param["address"]);
        	$business->setSuiteApt($param["suiteApt"]);
        	$business->setZipCode($param["zipCode"]);
        	$business->setSsn($param["ssn"]);
        	$business->setDba($param["dba"]);
        	$business->setDob($param["dob"]);
        	$business->setType($param["type"]);
        	$business->setBusinessDescription($param["businessDescription"]);
        	$business->setFedTaxID($param["fedTaxID"]);
        	$business->setBusinessAddress($param["businessAddress"]);
        	$business->setBusinessSuiteApt($param["businessSuiteApt"]);
        	$business->setBusinessZipCode($param["businessZipCode"]);
        	$business->setCcSales($param["ccSales"]);
        	$business->setHighestSales($param["highestSales"]);
        	$business->setYearInBusiness($param["yearsInBusiness"]);
        	$em = $this->getDoctrine()->getManager();
        	$em->persist($business);
        	$em->flush();
	}
	$response = new Response("Batch");	
    	$response->setStatusCode(201);
	return $response;
    }
}

?>
