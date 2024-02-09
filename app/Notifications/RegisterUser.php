<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class RegisterUser extends Notification
{
    use Queueable;

    /**
     * Create a new notification instance.
     *
     * @return void
     */
    public $password;

    public function __construct($clave)
    {
        $this->password = $clave;
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
            ->subject(__('Notificación de Registro'))
            ->greeting(__("**Apreciado(a):** :fullname\n", ['fullname' => $notifiable->persona->fullname]))
            ->line(__("Ante todo reciba Ud. un cordial saludo. A través de este comunicado, se le informa que ya podrá ingresar al :Sistema. A continuación, los datos de ingreso son: \n", ['Sistema' => config('app.name')]))
            ->line(__("**Usuario:** :user\n", ['user' => $notifiable->email]))
            ->line(__("**Clave:** :clave\n", ['clave' => $this->password]))
            ->action('Ingresar al sistema', env('FRONTEND_URL'))
            ->line("Por su seguridad, recomendamos cambiar su contraseña periódicamente.\n")
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
