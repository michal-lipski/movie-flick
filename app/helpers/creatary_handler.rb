class CreataryHandler
 
  def authorized(user, session)
    # should return the URL to which Creatary should redirect
  end

  def denied(session)
    # should return the URL to which Creatary should redirect
  end

  def receive_sms(from_user, to_app, body, transaction_id)
    #TODO add films processing
    response = 'film info'
    Creatary::API.send_sms(to_app, from_user, response, transaction_id)
    log_request(body, from_user, response)
  end

  def log_request(body, from_user, response)
    Rails.logger.info "Sending response... #{response} for request #{body}"
  end

  def lifecycle_notification(channel, invoker, reason, application_name, notification_type, access_tokens)
  end

end