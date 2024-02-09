<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class SolicitudEquipo extends Notification
{
    use Queueable;

    /**
     * Create a new notification instance.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    /**
     * Get the notification's delivery channels.
     *
     * @param  mixed  $notifiable
     * @return array
     */
    public function via($notifiable)
    {
        return ['mail'];
    }

    /**
     * Get the mail representation of the notification.
     *
     * @param  mixed  $notifiable
     * @return \Illuminate\Notifications\Messages\MailMessage
     */
    public function toMail($notifiable)
    {
        return (new MailMessage)
            ->subject(__('Notificación de Solicitud Recibida'))
            ->greeting(__("**Apreciado(a):** :fullname\n", ['fullname' => $notifiable->persona->fullname]))
            ->line(__("Ante todo reciba Ud. un cordial saludo. A través de este comunicado, se le informa que ha sido solicitado(a) para formar parte de un equipo, haga click en el siguiente botón para obtener más detalles."))
            ->action('Visualizar solicitud', env('FRONTEND_URL') . '/Solicitudes_recibidas')
            ->line("El presente correo es enviado automáticamente por nuestro sistema, por favor, no responda ni reenvíe mensajes a esta dirección.\n")
            ->line("Para mayor información consultar nuestro Sitio Web www.uptecms.edu.ve, o comunicarse a través de las siguientes vías: Instagram: @uptecms_dgc | Facebook: Gestión Comunicacional | Twitter: @UniversidadPms.\n");
    }

    /**
     * Get the array representation of the notification.
     *
     * @param  mixed  $notifiable
     * @return array
     */
    public function toArray($notifiable)
    {
        return [
            //
        ];
    }
}
